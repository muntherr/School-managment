import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../api-handling/connectionSetup.dart';

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  var mappedTherapistData;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController(); // For adding a new student
  final TextEditingController updateDeleteIdController = TextEditingController(); // For updating/deleting a student
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String? selectedGender;

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
        title: Text('Student Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTextFormField(idController, 'ID for New Student'),
                _buildTextFormField(firstNameController, 'First Name', requiredField: true),
                _buildTextFormField(lastNameController, 'Last Name', requiredField: true),
                _buildTextFormField(emailController, 'Email'),
                _buildTextFormField(phoneNumberController, 'Phone Number'),
                _buildTextFormField(ageController, 'Age'),
                _buildGenderDropdown(),
                Center(
                  child: SizedBox(
                    width: 200.0,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Add Student'),
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
      child: DropdownButtonFormField<String>(
        value: selectedGender,
        decoration: _inputDecoration.copyWith(labelText: 'Gender'),
        items: <String>['M', 'F']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedGender = newValue;
          });
        },
        validator: (value) => value == null ? 'Please select a gender' : null,
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
            onPressed: _getStudentData,
            child: Text('Get Student Data'),
          ),
        ),
        SizedBox(height: 8), // Space between buttons
        SizedBox(
          width: buttonWidth,
          child: ElevatedButton(
            onPressed: _updateStudent,
            child: Text('Update Student'),
          ),
        ),
        SizedBox(height: 8), // Space between buttons
        SizedBox(
          width: buttonWidth,
          child: ElevatedButton(
            onPressed: _deleteStudent,
            child: Text('Delete Student'),
            style: ElevatedButton.styleFrom(primary: Colors.red),
          ),
        ),
      ],
    );
  }


  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      studentModel studentData = studentModel(
        id: idController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        age: ageController.text,
        gender: selectedGender!,
      );
      await postData("/add_student", studentData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Student is Added successfully'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
  void _getStudentData() async {
    String studentId = updateDeleteIdController.text;
    if (studentId.isNotEmpty) {
      var responseData = await getData('/find_student/$studentId');
      // Decode the response assuming it's a JSON string representing a list
      List jsonResponse = json.decode(responseData);

      // Check if the list is not empty and extract the first student data
      if (jsonResponse.isNotEmpty) {
        var studentData = jsonResponse[0]; // Get the first student data from the list
        studentModel student = studentModel.fromJson(studentData);
        setState(() {
          idController.text = student.id ?? '';
          firstNameController.text = student.firstName ?? '';
          lastNameController.text = student.lastName ?? '';
          emailController.text = student.email ?? '';
          phoneNumberController.text = student.phoneNumber.toString();
          ageController.text = student.age.toString();
          selectedGender = student.gender;
        });
      } else {
        print('No student found with ID $studentId');
      }
    } else {
      print('Please enter a student ID');
    }
  }



  void _updateStudent() async {
    String studentId = updateDeleteIdController.text;
    if (studentId.isNotEmpty) {
      // Create a map or an object representing the student data to be updated
      Map<String, dynamic> studentData = {
        '_id': studentId,
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': emailController.text,
        'phoneNumber': phoneNumberController.text,
        'age': ageController.text,
        'gender': selectedGender,
      };
      await patchData('/update_student/$studentId', studentData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Student with ID $studentId updated successfully'),
          duration: Duration(seconds: 3),
        ),
      );
      print('Student with ID $studentId updated');
    } else {
      print('Please enter a student ID');
    }
  }


  void _deleteStudent() async {
    String studentId = updateDeleteIdController.text;
    if (studentId.isNotEmpty) {
      await deleteData('/delete_student/$studentId', studentId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Student with ID $studentId deleted successfully'),
          duration: Duration(seconds: 3),
        ),
      );
      print('Student with ID $studentId deleted');
    } else {
      print('Please enter a student ID to delete');
    }
  }

  @override
  void dispose() {
    idController.dispose();
    updateDeleteIdController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    ageController.dispose();
    super.dispose();
  }
}
