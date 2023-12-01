import 'package:flutter/material.dart';
import 'add_instructor_screen.dart';
import 'add_course_screen.dart';
import 'add_student_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        toolbarHeight: 140,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipPath(
          clipper: AppBarCustomClipper(),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF5D69A5),
                  Color(0xFFA27B90),
                ],
              ),
            ),
            child: Center(
              child: Text(
                'School Management System',
                style: GoogleFonts.exo2(
                  color: Color(0xFFFFFFFF),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/2203_w037_n003_234b_p1_234.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200, // Adjust the button width as needed
                height: 60, // Adjust the button height as needed
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddInstructorScreen()),
                    );
                  },
                  child: Text('Add Instructor'),
                ),
              ),
              SizedBox(height: 20), // Add spacing between buttons
              SizedBox(
                width: 200, // Adjust the button width as needed
                height: 60, // Adjust the button height as needed
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCourseScreen()),
                    );
                  },
                  child: Text('Add Course'),
                ),
              ),
              SizedBox(height: 20), // Add spacing between buttons
              SizedBox(
                width: 200, // Adjust the button width as needed
                height: 60, // Adjust the button height as needed
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddStudentScreen()),
                    );
                  },
                  child: Text('Add Student'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
