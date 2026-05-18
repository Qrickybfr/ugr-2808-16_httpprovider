import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../Models/model.dart';
import '../core/api_constants.dart';

class ApiService {
  /// GET ALL GRADES (STUDENT RECORDS)
  static Future<List<StudentGrade>> getGrades() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.todos}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final List data = body['todos'];

      List<StudentGrade> grades = data.map((item) => StudentGrade.fromTodoJson(item)).toList();

      grades.shuffle(Random());
      return grades.take(5).toList();
    } else {
      throw Exception('Failed to load student register');
    }
  }

  /// GET SINGLE RECORD
  static Future<StudentGrade> getGrade(int id) async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.todos}/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return StudentGrade.fromTodoJson(data);
    } else {
      throw Exception('Failed to load student record');
    }
  }

  /// CREATE STUDENT RECORD
  static Future<StudentGrade> createGrade({
    required String subject,
    required int id,
    required bool isPassed,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addTodo}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'todo': subject,
        'completed': isPassed,
        'userId': id,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = json.decode(response.body);
      return StudentGrade.fromTodoJson(data);
    } else {
      throw Exception('Failed to create student record');
    }
  }

  /// UPDATE STUDENT RECORD
  static Future<StudentGrade> updateGrade(
    int recordId, {
    required String subject,
    required int id,
    required bool isPassed,
  }) async {
    final response = await http.put(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.todos}/$recordId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': recordId,
        'todo': subject,
        'userId': id,
        'completed': isPassed,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return StudentGrade.fromTodoJson(data);
    } else {
      throw Exception('Failed to update student record');
    }
  }

  /// PATCH STUDENT RECORD
  static Future<StudentGrade> patchGrade(
    int recordId, {
    String? subject,
    bool? isPassed,
  }) async {
    final response = await http.patch(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.todos}/$recordId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        if (subject != null) 'todo': subject,
        if (isPassed != null) 'completed': isPassed,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return StudentGrade.fromTodoJson(data);
    } else {
      throw Exception('Failed to patch student record');
    }
  }

  /// DELETE RECORD
  static Future<bool> deleteGrade(int recordId) async {
    final response = await http.delete(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.todos}/$recordId'));
    return response.statusCode == 200;
  }
}