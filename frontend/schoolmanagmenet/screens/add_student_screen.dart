import 'package:flutter/material.dart';

class AddStudentScreen extends StatelessWidget {
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
