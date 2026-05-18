import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/homescreen.dart';
import 'Providers/student_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GradeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
