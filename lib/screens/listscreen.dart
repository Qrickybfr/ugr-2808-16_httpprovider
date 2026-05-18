import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/student_provider.dart';
import '../Models/model.dart';
import 'formscreen.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('GradeBook Register', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22)),
        actions: [
          IconButton(
            onPressed: () => Provider.of<GradeProvider>(context, listen: false).fetchGrades(forceRefresh: true),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: Consumer<GradeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2));
          }
          if (provider.grades.isEmpty) {
            return const Center(child: Text('No grade records found.', style: TextStyle(color: Colors.white24, fontSize: 16)));
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            itemCount: provider.grades.length,
            separatorBuilder: (context, index) => const Divider(color: Colors.white10, height: 24, thickness: 1),
            itemBuilder: (context, index) {
              final record = provider.grades[index];
              final isCompleted = record.isPassed;

              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFF1A1A1A),
                      child: Icon(Icons.assignment_turned_in_outlined, color: Colors.white, size: 20),
                    ),
                    title: Text(record.subject, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Record ID: ${record.id}  |  ', style: const TextStyle(color: Colors.white54, fontSize: 12, height: 1.4)),
                          TextSpan(
                            text: isCompleted ? 'PASS' : 'FAIL',
                            style: TextStyle(
                              color: isCompleted ? const Color(0xFF00E676) : const Color(0xFFFF5252),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    isThreeLine: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () => _showPatchPrompt(context, record),
                        icon: const Icon(Icons.auto_fix_high, color: Colors.white, size: 16),
                        label: const Text('Patch', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 4),
                      TextButton.icon(
                        onPressed: () => showGradeForm(context, existingRecord: record),
                        icon: const Icon(Icons.edit_outlined, color: Colors.white, size: 16),
                        label: const Text('Edit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 4),
                      TextButton.icon(
                        onPressed: () async {
                          final scaffoldMessenger = ScaffoldMessenger.of(context);
                          await provider.deleteGrade(record.id);
                          scaffoldMessenger.showSnackBar(
                            SnackBar(
                              backgroundColor: const Color(0xFFFF5252),
                              content: const Text('Grade record deleted!', style: TextStyle(color: Colors.white)),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFFF5252), size: 16),
                        label: const Text('Remove', style: TextStyle(color: Color(0xFFFF5252), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () => showGradeForm(context),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  void _showPatchPrompt(BuildContext context, StudentGrade record) {
    final controller = TextEditingController(text: record.subject);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF121212),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Patch Course Name', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Enter new course name',
            hintStyle: TextStyle(color: Colors.white24),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          TextButton(
            onPressed: () async {
              final newSubject = controller.text.trim();
              if (newSubject.isNotEmpty) {
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                final provider = Provider.of<GradeProvider>(context, listen: false);
                Navigator.pop(ctx);
                await provider.patchGrade(record.id, newSubject);
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFF1E1E1E),
                    content: const Text('Grade record patched successfully!', style: TextStyle(color: Colors.white)),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            child: const Text('Patch', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
