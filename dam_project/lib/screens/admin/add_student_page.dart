// lib/screens/add_student_page.dart
import 'package:flutter/material.dart';
import '../../models/student.dart';
import '../../services/student_service.dart';

class AddStudentPage extends StatefulWidget {
  final Student? student; // For edit mode
  
  const AddStudentPage({super.key, this.student});
  
  // Check if in edit mode
  bool get isEditMode => student != null;

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  final StudentService _studentService = StudentService();
  
  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();

  String _selectedGroup = '12(A)';
  String _selectedStatus = 'active';
  List<String> groups = ['12(A)', '12(B)', '11(A)', '11(B)', '10(A)', '10(B)'];
  List<String> statusOptions = ['active', 'pending'];
  
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill form if in edit mode
    if (widget.isEditMode) {
      final student = widget.student!;
      _nameController.text = student.name;
      _emailController.text = student.email;
      _phoneController.text = student.phone ?? '';
      _studentIdController.text = student.studentId ?? '';
      _selectedGroup = student.group;
      _selectedStatus = student.status;
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      
      try {
        Student student;
        
        if (widget.isEditMode) {
          // Update existing student
          student = widget.student!.copyWith(
            name: _nameController.text,
            email: _emailController.text,
            group: _selectedGroup,
            phone: _phoneController.text.isNotEmpty ? _phoneController.text : null,
            studentId: _studentIdController.text.isNotEmpty ? _studentIdController.text : null,
            status: _selectedStatus,
          );
          await _studentService.updateStudent(student);
        } else {
          // Create new student
          student = Student(
            name: _nameController.text,
            email: _emailController.text,
            group: _selectedGroup,
            phone: _phoneController.text.isNotEmpty ? _phoneController.text : null,
            studentId: _studentIdController.text.isNotEmpty ? _studentIdController.text : null,
            status: _selectedStatus,
          );
          await _studentService.addStudent(student);
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.isEditMode 
                ? 'Student updated successfully!' 
                : 'Student added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Navigate back with result
        Navigator.pop(context, student);
        
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() => _isSubmitting = false);
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email address';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditMode ? 'Edit Student' : 'Add New Student'),
        backgroundColor: Color.fromARGB(255, 22, 17, 121),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: widget.isEditMode
            ? [
                IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Delete Student'),
                        content: Text('Are you sure you want to delete this student?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    );
                    
                    if (confirmed == true) {
                      await _studentService.deleteStudent(widget.student!.effectiveId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Student deleted')),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isEditMode ? 'Edit Student Information' : 'Student Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name *',
                  hintText: 'Enter student full name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter student name';
                  }
                  if (value.length < 3) {
                    return 'Name must be at least 3 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address *',
                  hintText: 'Enter student email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.email),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              SizedBox(height: 15),

              // Student ID Field
              TextFormField(
                controller: _studentIdController,
                decoration: InputDecoration(
                  labelText: 'Student ID',
                  hintText: widget.isEditMode 
                      ? widget.student!.studentId ?? 'Auto-generated'
                      : 'Leave empty for auto-generation',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.badge),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
              SizedBox(height: 15),

              // Group Selection
              DropdownButtonFormField<String>(
                value: _selectedGroup,
                decoration: InputDecoration(
                  labelText: 'Group *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.group),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                items: groups.map((String group) {
                  return DropdownMenuItem<String>(
                    value: group,
                    child: Text(group),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() => _selectedGroup = newValue);
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a group';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),

              // Status Selection (only for edit mode)
              if (widget.isEditMode) ...[
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: InputDecoration(
                    labelText: 'Status *',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.circle, color: _getStatusColor(_selectedStatus)),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  items: statusOptions.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: _getStatusColor(status),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(status.toUpperCase()),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => _selectedStatus = newValue);
                    }
                  },
                ),
                SizedBox(height: 15),
              ],

              // Phone Field
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter phone number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.phone),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 22, 17, 121),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isSubmitting
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(widget.isEditMode ? 'Updating...' : 'Adding...'),
                          ],
                        )
                      : Text(
                          widget.isEditMode ? 'Update Student' : 'Add Student',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),
            ],
          ),
        ),
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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _studentIdController.dispose();
    super.dispose();
  }
}