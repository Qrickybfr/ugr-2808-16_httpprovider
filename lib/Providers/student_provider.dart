import 'package:flutter/material.dart';
import '../Models/model.dart';
import '../Services/api_service.dart';

class GradeProvider with ChangeNotifier {
  List<StudentGrade> _grades = [];
  bool _isLoading = false;
  int _idCounter = 255;

  List<StudentGrade> get grades => _grades;
  bool get isLoading => _isLoading;

  Future<void> _run(Future<void> Function() action) async {
    _isLoading = true;
    notifyListeners();
    try {
      await action();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _runSilent(Future<void> Function() action) async {
    try {
      await action();
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchGrades({bool forceRefresh = false}) async {
    if (!forceRefresh && _grades.isNotEmpty) return;
    await _run(() async {
      final localRecords = _grades.where((record) => record.id >= 100000).toList();
      try {
        final apiRecords = await ApiService.getGrades();
        _grades = [...localRecords, ...apiRecords];
      } catch (e) {
        debugPrint('Fetch error: $e');
        _grades = localRecords;
      }
    });
  }

  Future<StudentGrade?> getGrade(int id) async {
    StudentGrade? result;
    await _run(() async {
      try {
        result = await ApiService.getGrade(id);
        if (result != null) _grades = [result!];
      } catch (e) {
        debugPrint('Get error: $e');
      }
    });
    return result;
  }

  Future<void> addGrade(String subject, int id, bool isPassed) async {
    await _runSilent(() async {
      final tempRecord = StudentGrade(
        id: _idCounter++,
        subject: subject,
        isPassed: isPassed,
      );
      _grades.insert(0, tempRecord);

      try {
        final apiRecord = await ApiService.createGrade(subject: subject, id: id, isPassed: isPassed);
        final index = _grades.indexWhere((record) => record.id == tempRecord.id);
        if (index != -1) {
          _grades[index] = StudentGrade(
            id: tempRecord.id,
            subject: apiRecord.subject,
            isPassed: apiRecord.isPassed,
          );
        }
      } catch (e) {
        debugPrint('Add API error (fallback to local success): $e');
      }
    });
  }

  Future<void> updateGrade(int recordId, int id, String subject, bool isPassed) async {
    await _runSilent(() async {
      final updatedRecord = StudentGrade(id: recordId, subject: subject, isPassed: isPassed);
      
      final index = _grades.indexWhere((record) => record.id == recordId);
      if (index != -1) _grades[index] = updatedRecord;

      if (recordId <= 150) {
        try {
          await ApiService.updateGrade(recordId, subject: subject, id: id, isPassed: isPassed);
        } catch (e) {
          debugPrint('Update API error (fallback to local success): $e');
        }
      }
    });
  }

  Future<void> patchGrade(int recordId, String subject) async {
    await _runSilent(() async {
      final index = _grades.indexWhere((record) => record.id == recordId);
      if (index == -1) return;
      
      final existingRecord = _grades[index];
      final patchedRecord = StudentGrade(
        id: recordId, 
        subject: subject, 
        isPassed: existingRecord.isPassed
      );

      
      _grades[index] = patchedRecord;

      if (recordId <= 150) {
        try {
          await ApiService.patchGrade(recordId, subject: subject);
        } catch (e) {
          debugPrint('Patch API error (fallback to local success): $e');
        }
      }
    });
  }

  Future<void> deleteGrade(int recordId) async {
    await _runSilent(() async {
      
      _grades.removeWhere((record) => record.id == recordId);

      if (recordId <= 150) {
        try {
          await ApiService.deleteGrade(recordId);
        } catch (e) {
          debugPrint('Delete API error (fallback to local success): $e');
        }
      }
    });
  }
}