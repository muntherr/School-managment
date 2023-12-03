import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/instructor_model.dart';
import '../api-handling/connectionSetup.dart';

class instructor_Screen extends StatefulWidget {
  @override
  _instructor_Screen createState() => _instructor_Screen();
}

class _instructor_Screen extends State<instructor_Screen> {
  var mappedTherapistData;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController updateDeleteIdController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController coursesController = TextEditingController();

  String? selectedCourse; // Now a nullable type
  final List<String> availableCourses = [
    'Mathematics', 'Physics', 'Chemistry', 'Biology', 'English'
  ];
  InputDecoration get _inputDecoration => InputDecoration(
    labelStyle: TextStyle(color: Colors.grey),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(color: Colors.grey, width: 1.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instructors Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTextFormField(idController, 'ID for New instructor'),
                _buildTextFormField(firstNameController, 'First Name', requiredField: true),
                _buildTextFormField(lastNameController, 'Last Name', requiredField: true),
                _buildTextFormField(phoneNumberController, 'Phone Number'),
                _buildGenderDropdown(),
                Center(
                  child: SizedBox(
                    width: 200.0,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Add new instructor'),
                    ),
                  ),
                ),
                _buildUpdateAndDeleteSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label, {bool requiredField = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: _inputDecoration.copyWith(
          labelText: label,
          suffixIcon: controller.text.isEmpty
              ? Container(width: 0)
              : IconButton(
            icon: Icon(Icons.clear, color: Colors.grey),
            onPressed: () => controller.clear(),
          ),
        ),
        validator: (value) {
          if (requiredField && value!.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child:  DropdownButtonFormField<String>(
        decoration: _inputDecoration.copyWith(labelText: 'Courses'),
        value: selectedCourse,
        onChanged: (String? newValue) {
          setState(() {
            selectedCourse = newValue;
          });
        },
        items: availableCourses.map<DropdownMenuItem<String>>((String course) {
          return DropdownMenuItem<String>(
            value: course,
            child: Text(course),
          );
        }).toList(),
      ),

    );
  }
  Widget _buildUpdateAndDeleteSection() {
    double buttonWidth = 200.0; // Define a fixed width for the buttons

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildTextFormField(updateDeleteIdController, 'ID for Update/Delete'),
        SizedBox(height: 8), // Space between text field and first button
        SizedBox(
          width: buttonWidth,
          child: ElevatedButton(
            onPressed: _getInstructorData,
            child: Text('Get Instructor info'),
          ),
        ),
        SizedBox(height: 8), // Space between buttons
        SizedBox(
          width: buttonWidth,
          child: ElevatedButton(
            onPressed: _updateInstructor,
            child: Text('Update Instructor'),
          ),
        ),
        SizedBox(height: 8), // Space between buttons
        SizedBox(
          width: buttonWidth,
          child: ElevatedButton(
            onPressed: _deleteInstructor,
            child: Text('Delete Instructor'),
            style: ElevatedButton.styleFrom(primary: Colors.red),
          ),
        ),
      ],
    );
  }


  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      instructorModel instructorData = instructorModel(
        id: idController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneNumberController.text,
        courses: selectedCourse!,
      );
      await postData("/add_instructor", instructorData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Instructor is Added successfully'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
  void _getInstructorData() async {
    String instructorId = updateDeleteIdController.text;
    if (instructorId.isNotEmpty) {
      var responseData = await getData('/find_instructor/$instructorId');
      // Decode the response assuming it's a JSON string representing a list
      List jsonResponse = json.decode(responseData);

      if (jsonResponse.isNotEmpty) {
        var instructorData = jsonResponse[0];
        instructorModel instructor = instructorModel.fromJson(instructorData);
        setState(() {
          idController.text = instructor.id ?? '';
          firstNameController.text = instructor.firstName ?? '';
          lastNameController.text = instructor.lastName ?? '';
          phoneNumberController.text = instructor.phoneNumber.toString();
          selectedCourse = instructor.courses;
        });
      } else {
        print('No instructor found with ID $instructorId');
      }
    } else {
      print('Please enter a instructor ID');
    }
  }



  void _updateInstructor() async {
    String instructorId = updateDeleteIdController.text;
    if (instructorId.isNotEmpty) {
      Map<String, dynamic> instructorData = {
        '_id': instructorId,
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'phoneNumber': phoneNumberController.text,
        'courses': selectedCourse,
      };
      await patchData('/update_instructor/$instructorId', instructorData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Instructor with ID $instructorId updated successfully'),
          duration: Duration(seconds: 3),
        ),
      );
      print('Instructor with ID $instructorId updated');
    } else {
      print('Please enter a instructor ID');
    }
  }


  void _deleteInstructor() async {
    String instructorId = updateDeleteIdController.text;
    if (instructorId.isNotEmpty) {
      await deleteData('/delete_instructor/$instructorId', instructorId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Instructor with ID $instructorId deleted successfully'),
          duration: Duration(seconds: 3),
        ),
      );
      print('Instructor with ID $instructorId deleted');
    } else {
      print('Please enter a instructor ID to delete');
    }
  }

  @override
  void dispose() {
    idController.dispose();
    updateDeleteIdController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    coursesController.dispose();
    super.dispose();
  }
}
