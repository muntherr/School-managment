import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:schoolmanagmenet/models/course_model.dart';
import '../api-handling/connectionSetup.dart';

class courseScreen extends StatefulWidget {
  @override
  _courseScreen createState() => _courseScreen();
}


class _courseScreen extends State<courseScreen> {
  var mappedCourseData;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController updateDeleteIdController = TextEditingController();
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController instructorController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

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
        title: Text('Courses Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTextFormField(idController, 'ID for New Course'),
                _buildTextFormField(courseNameController, 'Course Name', requiredField: true),
                _buildTextFormField(instructorController, 'Instructor Name', requiredField: true),
                _buildTextFormField(startDateController, 'Start Date'),
                _buildTextFormField(endDateController, 'End Date'),
                Center(
                  child: SizedBox(
                    width: 200.0,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Add new Course'),
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
            onPressed: _getCourseData,
            child: Text('Get Course info'),
          ),
        ),
        SizedBox(height: 8), // Space between buttons
        SizedBox(
          width: buttonWidth,
          child: ElevatedButton(
            onPressed: _updateCourse,
            child: Text('Update Course'),
          ),
        ),
        SizedBox(height: 8), // Space between buttons
        SizedBox(
          width: buttonWidth,
          child: ElevatedButton(
            onPressed: _deleteCourse,
            child: Text('Delete Course'),
            style: ElevatedButton.styleFrom(primary: Colors.red),
          ),
        ),
      ],
    );
  }
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      courseModel courseData = courseModel(
        id: idController.text,
        courseName: courseNameController.text,
        instructor: instructorController.text,
        startDate: startDateController.text,
        endDate: endDateController.text,
      );
      await postData("/add_course", courseData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Course is Added successfully'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
  void _getCourseData() async {
    String courseId = updateDeleteIdController.text;
    if (courseId.isNotEmpty) {
      var responseData = await getData('/find_course/$courseId');
      // Decode the response assuming it's a JSON string representing a list
      List jsonResponse = json.decode(responseData);

      if (jsonResponse.isNotEmpty) {
        var courseData = jsonResponse[0];
        courseModel instructor = courseModel.fromJson(courseData);
        setState(() {
          idController.text = instructor.id ?? '';
          courseNameController.text = instructor.courseName ?? '';
          instructorController.text = instructor.instructor ?? '';
          startDateController.text = instructor.startDate ?? '';
          endDateController.text = instructor.endDate ?? '';
        });
      } else {
        print('No Course found with ID $courseId');
      }
    } else {
      print('Please enter a Course ID');
    }
  }



  void _updateCourse() async {
    String courseId = updateDeleteIdController.text;
    if (courseId.isNotEmpty) {
      Map<String, dynamic> courseData = {
        '_id': courseId,
        'courseName': courseNameController.text,
        'instructor': instructorController.text,
        'startDate': startDateController.text,
        'endDate': endDateController.text,
      };
      await patchData('/update_course/$courseId', courseData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Course with ID $courseId updated successfully'),
          duration: Duration(seconds: 3),
        ),
      );
      print('Instructor with ID $courseId updated');
    } else {
      print('Please enter a instructor ID');
    }
  }


  void _deleteCourse() async {
    String courseId = updateDeleteIdController.text;
    if (courseId.isNotEmpty) {
      await deleteData('/delete_course/$courseId', courseId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Course with ID $courseId deleted successfully'),
          duration: Duration(seconds: 3),
        ),
      );
      print('Instructor with ID $courseId deleted');
    } else {
      print('Please enter a instructor ID to delete');
    }
  }

  @override
  void dispose() {
    idController.dispose();
    updateDeleteIdController.dispose();
    courseNameController.dispose();
    instructorController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }
}
