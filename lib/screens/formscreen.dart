import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/student_provider.dart';
import '../Models/model.dart';

void showGradeForm(BuildContext context, {StudentGrade? existingRecord}) {
  final idController =
      TextEditingController(text: existingRecord?.id.toString());
  final subjectController =
      TextEditingController(text: existingRecord?.subject);

  bool isPassed = existingRecord?.isPassed ?? false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.black,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  existingRecord == null ? 'New Grade Entry' : 'Edit Grade Entry',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: idController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Record ID (Starts from 255)',
                    hintStyle: TextStyle(color: Colors.white24),
                  ),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: subjectController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Subject',
                    hintStyle: TextStyle(color: Colors.white24),
                  ),
                ),
                const SizedBox(height: 12),

                DropdownButton<String>(
                  value: isPassed ? 'pass' : 'fail',
                  dropdownColor: Colors.black,
                  items: const [
                    DropdownMenuItem(
                      value: 'pass',
                      child: Text('Pass', style: TextStyle(color: Colors.green)),
                    ),
                    DropdownMenuItem(
                      value: 'fail',
                      child: Text('Fail', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      isPassed = val == 'pass';
                    });
                  },
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final provider =
                          Provider.of<GradeProvider>(context, listen: false);

                      final idText = idController.text.trim();
                      final subject = subjectController.text.trim();
                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      final navigator = Navigator.of(context);

                      final studentId = int.tryParse(idText) ?? 1;

                      if (idText.isEmpty || subject.isEmpty) return;

                      if (existingRecord == null) {
                        await provider.addGrade(
                            subject, studentId, isPassed);
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            backgroundColor: const Color(0xFF1E1E1E),
                            content: const Text('Grade record created successfully!', style: TextStyle(color: Colors.white)),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      } else {
                        await provider.updateGrade(existingRecord.id,
                            studentId, subject, isPassed);
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            backgroundColor: const Color(0xFF1E1E1E),
                            content: const Text('Grade record updated successfully!', style: TextStyle(color: Colors.white)),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }

                      navigator.pop();
                    },
                    child: Text(
                      existingRecord == null ? 'Add' : 'Update',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}