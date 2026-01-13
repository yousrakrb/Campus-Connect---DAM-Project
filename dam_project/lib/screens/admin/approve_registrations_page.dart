// lib/screens/approve_registrations_page.dart
import 'package:flutter/material.dart';
import '../../models/student.dart';
import '../../services/student_service.dart';

class ApproveRegistrationsPage extends StatefulWidget {
  const ApproveRegistrationsPage({super.key});

  @override
  State<ApproveRegistrationsPage> createState() => _ApproveRegistrationsPageState();
}

class _ApproveRegistrationsPageState extends State<ApproveRegistrationsPage> {
  final StudentService _studentService = StudentService();
  List<Student> _pendingStudents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPendingStudents();
  }

  Future<void> _loadPendingStudents() async {
    setState(() => _isLoading = true);
    try {
      final allStudents = await _studentService.getStudents();
      _pendingStudents = allStudents.where((s) => s.status == 'pending').toList();
    } catch (e) {
      print('Error loading pending students: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _approveStudent(Student student) async {
    try {
      final updatedStudent = student.copyWith(status: 'active');
      await _studentService.updateStudent(updatedStudent);
      
      setState(() {
        _pendingStudents.removeWhere((s) => s.id == student.id);
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${student.name} has been approved'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _rejectStudent(Student student) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reject Registration'),
        content: Text('Are you sure you want to reject ${student.name}\'s registration?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Reject'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _studentService.deleteStudent(student.effectiveId);
        setState(() {
          _pendingStudents.removeWhere((s) => s.id == student.id);
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${student.name}\'s registration has been rejected'),
            backgroundColor: Colors.orange,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Widget _buildPendingStudentCard(Student student) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange.withOpacity(0.2),
          child: Text(student.name[0].toUpperCase()),
        ),
        title: Text(student.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(student.email),
            Text('Group: ${student.group}'),
            if (student.phone != null) Text('Phone: ${student.phone}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.check_circle, color: Colors.green),
              onPressed: () => _approveStudent(student),
              tooltip: 'Approve',
            ),
            IconButton(
              icon: Icon(Icons.cancel, color: Colors.red),
              onPressed: () => _rejectStudent(student),
              tooltip: 'Reject',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approve Registrations'),
        backgroundColor: Color.fromARGB(255, 22, 17, 121),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _pendingStudents.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
                      SizedBox(height: 20),
                      Text(
                        'No pending registrations',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'All students have been approved',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        '${_pendingStudents.length} Pending Registration${_pendingStudents.length != 1 ? 's' : ''}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _loadPendingStudents,
                        child: ListView.builder(
                          itemCount: _pendingStudents.length,
                          itemBuilder: (context, index) {
                            return _buildPendingStudentCard(_pendingStudents[index]);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
