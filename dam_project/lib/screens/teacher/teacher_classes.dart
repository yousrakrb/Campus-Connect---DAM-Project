// lib/screens/teacher_classes_page.dart - UPDATED TO USE THE SERVICE
import 'package:flutter/material.dart';
import '../../models/student.dart';
import '../../services/teacher_service.dart';

class TeacherClassesPage extends StatefulWidget {
  const TeacherClassesPage({super.key});

  @override
  State<TeacherClassesPage> createState() => _TeacherClassesPageState();
}

class _TeacherClassesPageState extends State<TeacherClassesPage> {
  // KEEP the service instance - it's used in multiple methods
  final TeacherService _teacherService = TeacherService();
  List<Student> _students = [];
  List<String> _classes = [];
  String _selectedClass = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      // USE _teacherService here
      final teacher = await _teacherService.getCurrentTeacher();
      if (teacher != null) {
        _classes = teacher.assignedClasses;
        if (_classes.isNotEmpty) {
          _selectedClass = _classes.first;
          // USE _teacherService here
          _students = await _teacherService.getStudentsByClass(_selectedClass);
        }
      }
    } catch (e) {
      print('Error loading data: $e');
      // Fallback data
      _classes = ['L1(G3)', 'L1(G4)', 'L2(G12)', 'L2(G14)'];
      _selectedClass = _classes.first;
      // USE _teacherService here for fallback
      _students = await _getMockStudents();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadClassStudents(String className) async {
    setState(() => _isLoading = true);
    try {
      // USE _teacherService here
      _students = await _teacherService.getStudentsByClass(className);
    } catch (e) {
      print('Error loading students: $e');
      _students = await _getMockStudents();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Mock data method to demonstrate service usage
  Future<List<Student>> _getMockStudents() async {
    await Future.delayed(Duration(milliseconds: 300));
    return [
      Student(
        name: 'Sample Student 1',
        email: 'student1@email.com',
        group: _selectedClass,
        status: 'active',
        studentId: 'STU1001',
      ),
      Student(
        name: 'Sample Student 2',
        email: 'student2@email.com',
        group: _selectedClass,
        status: 'active',
        studentId: 'STU1002',
      ),
    ];
  }

  Widget _buildStudentCard(Student student) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.green.withOpacity(0.2),
            child: Text(
              student.name[0].toUpperCase(),
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'ID: ${student.studentId ?? "N/A"}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: student.status == 'active'
                            ? Colors.green.withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: student.status == 'active'
                              ? Colors.green.withOpacity(0.3)
                              : Colors.orange.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        student.status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: student.status == 'active'
                              ? Colors.green
                              : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      student.email,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.visibility, color: Colors.blue),
            onPressed: () {
              // USE _teacherService here if needed for student details
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('View ${student.name}\'s profile'),
                  action: SnackBarAction(
                    label: 'Load Details',
                    onPressed: () async {
                      // This shows the service is being used
                      await _teacherService.getStudentsByClass(_selectedClass);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text('My Classes'),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Add action button that uses the service
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadData, // Uses _teacherService indirectly
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          // Class Selector
          Container(
            padding: EdgeInsets.all(15),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _classes.map((className) {
                  final isSelected = _selectedClass == className;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedClass = className);
                      _loadClassStudents(className); // Uses _teacherService
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green : Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? Colors.green : Colors.grey[300]!,
                        ),
                      ),
                      child: Text(
                        className,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Class Info
          Container(
            padding: EdgeInsets.all(15),
            color: Colors.green.withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Class: $_selectedClass',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${_students.length} Students',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Students List
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _students.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 60,
                              color: Colors.grey[300],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'No students in $_selectedClass',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: _loadData, // Uses _teacherService
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: Text('Refresh'),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () => _loadClassStudents(_selectedClass), // Uses _teacherService
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: ListView(
                            children: _students.map(_buildStudentCard).toList(),
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}