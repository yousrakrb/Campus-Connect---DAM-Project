// lib/screens/teacher_attendance_page.dart
import 'package:flutter/material.dart';

class TeacherAttendancePage extends StatefulWidget {
  const TeacherAttendancePage({super.key});

  @override
  State<TeacherAttendancePage> createState() => _TeacherAttendancePageState();
}

class _TeacherAttendancePageState extends State<TeacherAttendancePage> {
  List<Map<String, dynamic>> _students = [
    {'name': 'Yousra', 'id': 'STU001', 'present': true},
    {'name': 'Ahmed', 'id': 'STU002', 'present': true},
    {'name': 'Sarah', 'id': 'STU003', 'present': false},
  ];
  String _selectedDate = 'Today, ${DateTime.now().day}/${DateTime.now().month}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text('Attendance'),
        backgroundColor: Colors.green,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Mark Attendance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Chip(label: Text(_selectedDate), backgroundColor: Colors.green.withOpacity(0.1)),
                ]),
                SizedBox(height: 10),
                Text('Class L1 - Mathematics', style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
          
          // Attendance List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: student['present'] ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                        child: Text(student['name'][0], style: TextStyle(
                          color: student['present'] ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                      SizedBox(width: 15),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(student['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('ID: ${student['id']}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                      ])),
                      Switch(
                        value: student['present'],
                        activeColor: Colors.green,
                        onChanged: (value) => setState(() => _students[index]['present'] = value),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Save Button
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: ElevatedButton.icon(
              onPressed: () {
                final presentCount = _students.where((s) => s['present']).length;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Attendance saved: $presentCount/${_students.length} present')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              icon: Icon(Icons.save),
              label: Text('Save Attendance'),
            ),
          ),
        ],
      ),
    );
  }
}