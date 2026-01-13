// lib/services/student_service.dart
import 'dart:async';
import '../models/student.dart';

class StudentService {
  // In-memory storage (replace with database later)
  static final List<Student> _students = [];
  
  // Initialize with some sample data
  static void initialize() {
    if (_students.isEmpty) {
      _students.addAll([
        Student(
          id: '1',
          studentId: '1123',
          name: 'Yousra',
          email: 'yousra@gmail.com',
          group: '12(B)',
          status: 'active',
          createdAt: DateTime.now().subtract(Duration(days: 30)),
        ),
        Student(
          id: '2',
          studentId: '1223',
          name: 'Yasmine',
          email: 'yasmine@gmail.com',
          group: '11(A)',
          status: 'active',
          createdAt: DateTime.now().subtract(Duration(days: 25)),
        ),
        Student(
          id: '3',
          studentId: '1323',
          name: 'Moh',
          email: 'moh@gmail.com',
          group: '12(B)',
          status: 'pending',
          createdAt: DateTime.now().subtract(Duration(days: 20)),
        ),
      ]);
    }
  }
  
  // Get all students
  Future<List<Student>> getStudents({String? searchQuery, String? statusFilter}) async {
    await Future.delayed(Duration(milliseconds: 300)); // Simulate network delay
    
    var filteredStudents = List<Student>.from(_students);
    
    // Apply search filter
if (searchQuery != null && searchQuery.isNotEmpty) {
  final query = searchQuery.toLowerCase();
  filteredStudents = filteredStudents.where((student) {
    return student.name.toLowerCase().contains(query) ||
           student.email.toLowerCase().contains(query) ||
           (student.studentId != null && 
            student.studentId!.toLowerCase().contains(query)) ||
           student.group.toLowerCase().contains(query);
  }).toList();
}
    
    // Apply status filter
    if (statusFilter != null && statusFilter.isNotEmpty && statusFilter != 'all') {
      filteredStudents = filteredStudents.where((student) => student.status == statusFilter).toList();
    }
    
    // Sort by creation date (newest first)
    filteredStudents.sort((a, b) => (b.createdAt ?? DateTime.now())
        .compareTo(a.createdAt ?? DateTime.now()));
    
    return filteredStudents;
  }
  
  // Add student
  Future<Student> addStudent(Student student) async {
    await Future.delayed(Duration(milliseconds: 300));
    
    final newStudent = student.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      studentId: student.studentId ?? _generateStudentId(),
      createdAt: DateTime.now(),
    );
    
    _students.insert(0, newStudent);
    return newStudent;
  }
  
  // Update student
  Future<Student> updateStudent(Student updatedStudent) async {
    await Future.delayed(Duration(milliseconds: 300));
    
    final index = _students.indexWhere((s) => s.id == updatedStudent.id);
    if (index != -1) {
      _students[index] = updatedStudent;
      return updatedStudent;
    }
    throw Exception('Student not found');
  }
  
  // Delete student
  Future<bool> deleteStudent(String studentId) async {
    await Future.delayed(Duration(milliseconds: 300));
    
    final initialLength = _students.length;
    _students.removeWhere((s) => s.id == studentId);
    return _students.length < initialLength;
  }
  
  // Get student by ID
  Future<Student?> getStudentById(String id) async {
    await Future.delayed(Duration(milliseconds: 200));
    return _students.firstWhere((s) => s.id == id);
  }
  
  // Generate student ID
  String _generateStudentId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return 'STU${timestamp.substring(timestamp.length - 6)}';
  }
  
  // Get statistics
  Future<Map<String, int>> getStatistics() async {
    await Future.delayed(Duration(milliseconds: 100));
    return {
      'total': _students.length,
      'active': _students.where((s) => s.status == 'active').length,
      'pending': _students.where((s) => s.status == 'pending').length,
    };
  }
}