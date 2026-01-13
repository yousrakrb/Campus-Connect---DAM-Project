// lib/screens/student_management_page.dart
import 'package:flutter/material.dart';
import '../../models/student.dart';
import '../../services/student_service.dart';
import 'add_student_page.dart';

class StudentManagementPage extends StatefulWidget {
  const StudentManagementPage({super.key});

  @override
  State<StudentManagementPage> createState() => _StudentManagementPageState();
}

class _StudentManagementPageState extends State<StudentManagementPage> {
  final StudentService _studentService = StudentService();
  List<Student> _students = [];
  bool _isLoading = true;
  String _searchQuery = '';
  String _statusFilter = 'all';
  final List<String> _statusOptions = ['all', 'active', 'pending'];
  
  @override
  void initState() {
    super.initState();
    StudentService.initialize();
    _loadStudents();
  }
  
  Future<void> _loadStudents() async {
    setState(() => _isLoading = true);
    try {
      final students = await _studentService.getStudents(
        searchQuery: _searchQuery,
        statusFilter: _statusFilter == 'all' ? null : _statusFilter,
      );
      setState(() => _students = students);
    } catch (e) {
      print('Error loading students: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load students')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
  
  Future<void> _deleteStudent(String studentId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Student'),
        content: Text('Are you sure you want to delete this student? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel', style: TextStyle(color: Colors.grey[700])),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Delete'),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      try {
        await _studentService.deleteStudent(studentId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Student deleted successfully'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Note: Would need to implement undo functionality
                _loadStudents();
              },
            ),
          ),
        );
        _loadStudents();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete student: $e')),
        );
      }
    }
  }
  
  void _navigateToAddStudent() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddStudentPage(),
      ),
    );
    
    if (result != null && result is Student) {
      _loadStudents();
    }
  }
  
  void _navigateToEditStudent(Student student) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddStudentPage(student: student),
      ),
    );
    
    if (result != null && result is Student) {
      _loadStudents();
    }
  }
  
  void _toggleStudentStatus(Student student) async {
    try {
      final newStatus = student.status == 'active' ? 'pending' : 'active';
      final updatedStudent = student.copyWith(status: newStatus);
      await _studentService.updateStudent(updatedStudent);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student status updated to $newStatus')),
      );
      _loadStudents();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: $e')),
      );
    }
  }
  
  Widget _buildStudentCard(Student student) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
          // Student Avatar
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 22, 17, 121).withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                student.name[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 22, 17, 121),
                ),
              ),
            ),
          ),
          
          SizedBox(width: 15),
          
          // Student Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        student.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _toggleStudentStatus(student),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: _getStatusColor(student.status),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          student.status.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  student.email,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    if (student.studentId != null) ...[
                      Chip(
                        label: Text('ID: ${student.studentId}'),
                        backgroundColor: Colors.grey[100],
                        labelStyle: TextStyle(fontSize: 11),
                      ),
                      SizedBox(width: 5),
                    ],
                    Chip(
                      label: Text('Group: ${student.group}'),
                      backgroundColor: Color.fromARGB(255, 22, 17, 121).withOpacity(0.1),
                      labelStyle: TextStyle(
                        fontSize: 11,
                        color: Color.fromARGB(255, 22, 17, 121),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Action Buttons
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                _navigateToEditStudent(student);
              } else if (value == 'delete') {
                _deleteStudent(student.effectiveId);
              } else if (value == 'view') {
                _showStudentDetails(student);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'view',
                child: Row(
                  children: [
                    Icon(Icons.visibility, color: Colors.blue, size: 20),
                    SizedBox(width: 8),
                    Text('View Details'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.green, size: 20),
                    SizedBox(width: 8),
                    Text('Edit'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Text('Delete'),
                  ],
                ),
              ),
            ],
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.more_vert, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
  
  void _showStudentDetails(Student student) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Student Header
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 22, 17, 121).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Center(
                      child: Text(
                        student.name[0].toUpperCase(),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 22, 17, 121),
                        ),
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
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          student.group,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => _navigateToEditStudent(student),
                    icon: Icon(Icons.edit, color: Color.fromARGB(255, 22, 17, 121)),
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 10),
              
              // Student Details
              _buildDetailItem('Email', student.email, Icons.email),
              _buildDetailItem('Student ID', student.studentId ?? 'Auto-generated', Icons.badge),
              _buildDetailItem('Phone', student.phone ?? 'Not provided', Icons.phone),
              _buildDetailItem('Status', student.status.toUpperCase(), Icons.circle,
                  color: _getStatusColor(student.status)),
              if (student.createdAt != null)
                _buildDetailItem('Added on', 
                  '${student.createdAt!.day}/${student.createdAt!.month}/${student.createdAt!.year}', 
                  Icons.calendar_today),
              
              SizedBox(height: 20),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _navigateToEditStudent(student);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 22, 17, 121),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Edit Profile'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _deleteStudent(student.effectiveId),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[100],
                        foregroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Delete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildDetailItem(String label, String value, IconData icon, {Color? color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: color ?? Color.fromARGB(255, 22, 17, 121), size: 20),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
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
        title: Text('Student Management'),
        backgroundColor: Color.fromARGB(255, 22, 17, 121),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadStudents,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Bar
          Container(
            padding: EdgeInsets.all(15),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search by name, email, ID, or group...',
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(horizontal: 15),
                            suffixIcon: _searchQuery.isNotEmpty
                                ? IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() => _searchQuery = '');
                                      _loadStudents();
                                    },
                                  )
                                : null,
                          ),
                          onChanged: (value) {
                            setState(() => _searchQuery = value);
                            _loadStudents();
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 22, 17, 121),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: PopupMenuButton<String>(
                        onSelected: (value) {
                          setState(() => _statusFilter = value);
                          _loadStudents();
                        },
                        itemBuilder: (context) => _statusOptions.map((status) {
                          return PopupMenuItem(
                            value: status,
                            child: Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: status == 'all' 
                                        ? Colors.grey 
                                        : _getStatusColor(status),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(status.toUpperCase()),
                              ],
                            ),
                          );
                        }).toList(),
                        child: Icon(Icons.filter_list, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Showing ${_students.length} student${_students.length != 1 ? 's' : ''}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Filter: ${_statusFilter.toUpperCase()}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
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
                              size: 80,
                              color: Colors.grey[300],
                            ),
                            SizedBox(height: 20),
                            Text(
                              _searchQuery.isNotEmpty
                                  ? 'No students found for "$_searchQuery"'
                                  : 'No students available',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              _searchQuery.isNotEmpty
                                  ? 'Try a different search term'
                                  : 'Tap + to add your first student',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadStudents,
                        child: ListView.builder(
                          itemCount: _students.length,
                          itemBuilder: (context, index) {
                            return _buildStudentCard(_students[index]);
                          },
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddStudent,
        backgroundColor: Color.fromARGB(255, 22, 17, 121),
        child: Icon(Icons.add, color: Colors.white),
        tooltip: 'Add Student',
      ),
    );
  }
}