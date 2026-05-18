import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/student_provider.dart';
import 'listscreen.dart';
import 'formscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text('Student Grade\nTracker', style: TextStyle(color: Colors.white, fontSize: 44, fontWeight: FontWeight.bold, height: 1.0)),
              const SizedBox(height: 12),
              const Text('Track student course enrollments and mark Pass / Fail status.', style: TextStyle(color: Colors.white54, fontSize: 14)),
              const Spacer(),
              _buildBtn(context, Icons.list_alt_rounded, 'View GradeBook', 'View all active grades', () {
                Provider.of<GradeProvider>(context, listen: false).fetchGrades();
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ListScreen()));
              }),
              const SizedBox(height: 14),
              _buildBtn(context, Icons.add_rounded, 'New Grade Entry', 'Add student course and status', () => showGradeForm(context)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBtn(BuildContext context, IconData icon, String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
