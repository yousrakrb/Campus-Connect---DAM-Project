// lib/screens/assign_courses_page.dart
import 'package:flutter/material.dart';

class AssignCoursesPage extends StatefulWidget {
  const AssignCoursesPage({super.key});

  @override
  State<AssignCoursesPage> createState() => _AssignCoursesPageState();
}

class _AssignCoursesPageState extends State<AssignCoursesPage> {
  // This is a placeholder - you'll need to implement actual course logic
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Courses'),
        backgroundColor: Color.fromARGB(255, 22, 17, 121),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 80, color: Colors.grey[300]),
            SizedBox(height: 20),
            Text(
              'Course Assignment',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Assign courses to students and teachers',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement course assignment
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Course assignment feature coming soon!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 22, 17, 121),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text('Manage Courses'),
            ),
          ],
        ),
      ),
    );
  }
}
