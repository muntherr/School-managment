import 'package:flutter/material.dart';

class AddInstructorScreen extends StatelessWidget {
  const AddInstructorScreen({super.key});

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
