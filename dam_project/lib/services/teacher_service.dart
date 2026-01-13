// lib/services/teacher_service.dart
import 'dart:async';
import '../models/teacher.dart';
import '../models/student.dart';
import '../services/student_service.dart';

class TeacherService {
  // In-memory storage for teachers
  static final List<Teacher> _teachers = [
    Teacher(
      id: '1',
      teacherId: 'T001',
      name: 'Dr. Sediki',
      email: 'dr.sediki@school.edu',
      department: 'Mathematics',
      phone: '+213 123 456 789',
      subjects: ['Algebra', 'Calculus'],
      assignedClasses: ['L1'],
      createdAt: DateTime.now().subtract(Duration(days: 365)),
      qualification: 'Ph.D. in Mathematics',
      experienceYears: 15,
    ),
    Teacher(
      id: '2',
      teacherId: 'T002',
      name: 'Prof. Sediki',
      email: 'prof.sediki@school.edu',
      department: 'Physics',
      phone: '+213 987 654 321',
      subjects: ['Mechanics'],
      assignedClasses: ['L1', 'L2',],
      createdAt: DateTime.now().subtract(Duration(days: 300)),
      qualification: 'M.Sc. in Physics',
      experienceYears: 10,
    ),
    Teacher(
      id: '3',
      teacherId: 'T003',
      name: 'Ms. Sediki',
      email: 'ms.sediki@school.edu',
      department: 'Chemistry',
      phone: '+213 456 789 012',
      subjects: ['Machine Structure'],
      assignedClasses: ['L1'],
      createdAt: DateTime.now().subtract(Duration(days: 200)),
      qualification: 'M.Sc. in Chemistry',
      experienceYears: 8,
    ),
  ];

  // Get current teacher (simulating logged-in teacher)
  Future<Teacher?> getCurrentTeacher() async {
    await Future.delayed(Duration(milliseconds: 200));
    // In a real app, get from authentication/session
    return _teachers.first; // Returns Dr. Sediki as current teacher
  }

  // Get all students for the current teacher's classes
  Future<List<Student>> getMyStudents() async {
    await Future.delayed(Duration(milliseconds: 300));
    
    // Get current teacher's assigned classes
    final currentTeacher = await getCurrentTeacher();
    if (currentTeacher == null) return [];
    
    // Get all students
    final studentService = StudentService();
    final allStudents = await studentService.getStudents();
    
    // Filter students by teacher's assigned classes
    return allStudents.where((student) {
      return currentTeacher.assignedClasses.contains(student.group);
    }).toList();
  }

  // Get students by specific class
  Future<List<Student>> getStudentsByClass(String className) async {
    await Future.delayed(Duration(milliseconds: 200));
    
    // Check if current teacher teaches this class
    final currentTeacher = await getCurrentTeacher();
    if (currentTeacher == null || !currentTeacher.assignedClasses.contains(className)) {
      return [];
    }
    
    // Get students for this class
    final studentService = StudentService();
    final allStudents = await studentService.getStudents();
    
    return allStudents.where((student) => student.group == className).toList();
  }

  // Get all teachers
  Future<List<Teacher>> getAllTeachers() async {
    await Future.delayed(Duration(milliseconds: 300));
    return List.from(_teachers);
  }

  // Get teacher by ID
  Future<Teacher?> getTeacherById(String id) async {
    await Future.delayed(Duration(milliseconds: 200));
    return _teachers.firstWhere((teacher) => teacher.id == id);
  }

  // Add a new teacher
  Future<Teacher> addTeacher(Teacher teacher) async {
    await Future.delayed(Duration(milliseconds: 300));
    
    final newTeacher = teacher.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      teacherId: teacher.teacherId ?? _generateTeacherId(),
      createdAt: DateTime.now(),
    );
    
    _teachers.add(newTeacher);
    return newTeacher;
  }

  // Update teacher
  Future<Teacher> updateTeacher(Teacher updatedTeacher) async {
    await Future.delayed(Duration(milliseconds: 300));
    
    final index = _teachers.indexWhere((t) => t.id == updatedTeacher.id);
    if (index != -1) {
      _teachers[index] = updatedTeacher;
      return updatedTeacher;
    }
    throw Exception('Teacher not found');
  }

  // Delete teacher
  Future<bool> deleteTeacher(String teacherId) async {
    await Future.delayed(Duration(milliseconds: 300));
    
    final initialLength = _teachers.length;
    _teachers.removeWhere((t) => t.id == teacherId);
    return _teachers.length < initialLength;
  }

  // Get teacher statistics
  Future<Map<String, dynamic>> getTeacherStatistics() async {
    await Future.delayed(Duration(milliseconds: 200));
    
    final currentTeacher = await getCurrentTeacher();
    if (currentTeacher == null) {
      return {
        'totalClasses': 0,
        'totalStudents': 0,
        'subjects': [],
      };
    }
    
    final myStudents = await getMyStudents();
    
    return {
      'totalClasses': currentTeacher.assignedClasses.length,
      'totalStudents': myStudents.length,
      'subjects': currentTeacher.subjects,
      'experienceYears': currentTeacher.experienceYears,
    };
  }

  // Get today's schedule for teacher
  Future<List<Map<String, dynamic>>> getTodaySchedule() async {
    await Future.delayed(Duration(milliseconds: 300));
    
    final currentTeacher = await getCurrentTeacher();
    if (currentTeacher == null) return [];
    
    // Mock schedule data - in real app, fetch from database
    return [
      {
        'time': '08:00 - 09:30',
        'subject': currentTeacher.subjects.isNotEmpty ? currentTeacher.subjects[0] : 'Mathematics',
        'class': currentTeacher.assignedClasses.isNotEmpty ? currentTeacher.assignedClasses[0] : '12(A)',
        'room': 'Room 1',
        'type': 'Lecture',
      },
      {
        'time': '10:00 - 11:30',
        'subject': currentTeacher.subjects.length > 1 ? currentTeacher.subjects[1] : 'Calculus',
        'class': currentTeacher.assignedClasses.length > 1 ? currentTeacher.assignedClasses[1] : '12(B)',
        'room': 'Room 2',
        'type': 'Tutorial',
      },
    ];
  }

  // Generate teacher ID
  String _generateTeacherId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return 'T${timestamp.substring(timestamp.length - 4)}';
  }
}