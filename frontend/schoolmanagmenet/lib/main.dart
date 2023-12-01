import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(SchoolManagementApp());
}

class SchoolManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Management',
      home: HomeScreen(),
    );
  }
}
