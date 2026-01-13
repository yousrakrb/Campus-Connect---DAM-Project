// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/student/student_dashboard.dart';
import 'screens/admin/student_management_page.dart';
import 'screens/admin/add_student_page.dart'; 
void main() {
  runApp(const CampusConnectApp());
}

class CampusConnectApp extends StatelessWidget {
  const CampusConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 22, 17, 121), // Purple-blue from your design
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFF5F7FA), // Light grey background
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 22, 17, 121),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color.fromARGB(255, 22, 17, 121),
          unselectedItemColor: Colors.grey,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      home: StudentDashboardScreen(),
      routes: {
        '/students': (context) => StudentManagementPage(),
        '/add-student': (context) => AddStudentPage(),
      },
    );
  }
}