// lib/screens/teacher_dashboard.dart
import 'package:flutter/material.dart';
import '../../models/teacher.dart';
import '../../services/teacher_service.dart';
import 'teacher_classes.dart';
import 'teacher_attendance.dart';
import 'teacher_grade.dart';
import 'teacher_schedule.dart';


class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  final TeacherService _teacherService = TeacherService();
  Teacher? _currentTeacher;
  int _selectedIndex = 0;
  
  final List<Map<String, dynamic>> _todaySchedule = [
    {'time': '08:00-09:30', 'subject': 'Mathematics', 'class': '12(A)', 'room': '101'},
    {'time': '10:00-11:30', 'subject': 'Physics', 'class': '11(B)', 'room': '102'},
    {'time': '14:00-15:30', 'subject': 'Math Lab', 'class': '12(A)', 'room': 'Lab 1'},
  ];

  @override
  void initState() {
    super.initState();
    _loadTeacherData();
  }

  Future<void> _loadTeacherData() async {
    _currentTeacher = await _teacherService.getCurrentTeacher();
    setState(() {});
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color),
          ),
          SizedBox(height: 5),
          Text(title, style: TextStyle(color: Colors.grey[700], fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(Map<String, dynamic> session) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(session['subject'], style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Row(children: [
                  Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                  SizedBox(width: 5),
                  Text(session['time']),
                  SizedBox(width: 15),
                  Icon(Icons.room, size: 14, color: Colors.grey[600]),
                  SizedBox(width: 5),
                  Text('Room ${session['room']}'),
                ]),
              ],
            ),
          ),
          Chip(label: Text(session['class']), backgroundColor: Colors.green.withOpacity(0.1)),
        ],
      ),
    );
  }

  Widget _buildQuickAction(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 5),
            Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey[800])),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Container(
              padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('TEACHER DASHBOARD', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(_currentTeacher?.name ?? 'Loading...', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                      ]),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.green,
                        child: Text(_currentTeacher?.name[0] ?? 'T', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    children: [
                      _buildStatCard('Students', '156', Colors.blue),
                      _buildStatCard('Today\'s Classes', '3', Colors.green),
                      _buildStatCard('Pending Grades', '24', Colors.orange),
                      _buildStatCard('Attendance %', '94%', Colors.purple),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Today\'s Classes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Column(children: _todaySchedule.map(_buildScheduleItem).toList()),
                ],
              ),
            ),

            // QUICK ACTIONS
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15),
                  Wrap(spacing: 10, runSpacing: 10, children: [
                    _buildQuickAction('My Classes', Icons.class_, Colors.blue, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherClassesPage()));
                    }),
                   _buildQuickAction('Attendance', Icons.checklist, Colors.green, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherAttendancePage()));
                    }),
                    _buildQuickAction('Enter Grades', Icons.grading, Colors.orange, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherGradingPage()));
                    }),
                    _buildQuickAction('Schedule', Icons.calendar_today, Colors.purple, () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherSchedulePage()));
                    }),
                  ]),
                ],
              ),
            ),

            // PROFILE SECTION (Simplified - no navigation)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TEACHER PROFILE', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15),
                  Row(children: [
                    CircleAvatar(radius: 30, backgroundColor: Colors.green, child: Icon(Icons.person, color: Colors.white)),
                    SizedBox(width: 15),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(_currentTeacher?.name ?? 'Teacher Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(_currentTeacher?.department ?? 'Department', style: TextStyle(color: Colors.grey[600])),
                    ]),
                  ]),
                  SizedBox(height: 15),
                  if (_currentTeacher?.subjects?.isNotEmpty ?? false)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Subjects:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700])),
                        SizedBox(height: 5),
                        Text(_currentTeacher!.subjects.join(', '), style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  SizedBox(height: 10),
                  if (_currentTeacher?.phone != null)
                    Row(
                      children: [
                        Icon(Icons.phone, size: 16, color: Colors.grey[600]),
                        SizedBox(width: 8),
                        Text(_currentTeacher!.phone!, style: TextStyle(color: Colors.grey[700])),
                      ],
                    ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.email, size: 16, color: Colors.grey[600]),
                      SizedBox(width: 8),
                      Text(_currentTeacher?.email ?? 'teacher@school.edu', style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          switch (index) {
            case 0: 
              // Already on dashboard
              break;
            case 1: 
              Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherClassesPage())); 
              break;
            case 2: 
              Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherGradingPage())); 
              break;
            case 3: 
              // Settings/More options instead of Profile
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('More options coming soon')),
              );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.class_), label: 'Classes'),
          BottomNavigationBarItem(icon: Icon(Icons.grading), label: 'Grades'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'), // Changed from Profile
        ],
      ),
    );
  }
}