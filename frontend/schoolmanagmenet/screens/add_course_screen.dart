import 'package:flutter/material.dart';

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
