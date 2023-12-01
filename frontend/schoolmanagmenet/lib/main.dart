import 'package:flutter/material.dart';

void main() {
  runApp(const SchoolManagementApp());
}

class SchoolManagementApp extends StatelessWidget {
  const SchoolManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'School Management',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('School Management System'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddInstructorScreen()),
                );
              },
              child: const Text('Add Instructor'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCourseScreen()),
                );
              },
              child: Text('Add Course'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddStudentScreen()),
                );
              },
              child: Text('Add Student'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddInstructorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Instructor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Instructor input fields (e.g., name, email, etc.)
            // Add a form and input fields here
            ElevatedButton(
              onPressed: () {
                // Handle instructor data submission to the server
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddCourseScreen extends StatelessWidget {
  const AddCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Course'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Course input fields (e.g., name, description, etc.)
            // Add a form and input fields here
            ElevatedButton(
              onPressed: () {
                // Handle course data submission to the server
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Student input fields (e.g., name, age, etc.)
            // Add a form and input fields here
            ElevatedButton(
              onPressed: () {
                // Handle student data submission to the server
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
