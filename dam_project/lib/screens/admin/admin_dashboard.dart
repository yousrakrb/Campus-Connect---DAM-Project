// lib/screens/admin_dashboard.dart - UPDATED WITH FUNCTIONAL BUTTONS
import 'package:flutter/material.dart';
import 'student_management_page.dart';
import 'upload_files_pages.dart';
import 'approve_registrations_page.dart';
import 'assign_courses_page.dart';
import 'schedule_page.dart';
import 'send_notification_page.dart';
import 'add_student_page.dart'; // Add this import
import '../../services/student_service.dart'; // For statistics

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final StudentService _studentService = StudentService();
  Map<String, int> _stats = {
    'total': 0,
    'teachers': 22,
    'courses': 14,
    'attendance': 85,
  };
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    setState(() => _isLoading = true);
    try {
      final studentStats = await _studentService.getStatistics();
      setState(() {
        _stats['total'] = studentStats['total'] ?? 0;
      });
    } catch (e) {
      print('Error loading stats: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isLoading && (title.contains('students') || title.contains('Attendance'))
              ? SizedBox(
                  height: 28,
                  width: 28,
                  child: CircularProgressIndicator(
                    color: color,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
          SizedBox(height: 5),
          Text(title, style: TextStyle(color: Colors.grey[700], fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildQuickAction(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
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
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeachersList() {
    List<Map<String, String>> teachers = [
      {'name': 'Dr. Sediki', 'subject': 'Mathematics'},
      {'name': 'Prof. Sediki', 'subject': 'Physics'},
      {'name': 'Ms. Sediki', 'subject': 'Chemistry'},
      {'name': 'Mr. Sediki', 'subject': 'Biology'},
    ];

    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: teachers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('View ${teachers[index]['name']}\'s profile'),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Color(0xFF4F46E5),
                    child: Text(
                      teachers[index]['name']![0],
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        teachers[index]['name']!,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        teachers[index]['subject']!,
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContactInfo(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFF4F46E5), size: 20),
        SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: 16, color: Colors.grey[800])),
      ],
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
            // TOP BAR WITH PROFILE
            Container(
              padding: EdgeInsets.only(
                top: 40,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome and Profile
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DASHBOARD',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Admin User',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('View profile')),
                          );
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Color(0xFF4F46E5),
                          child: Text(
                            'A',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Quick Stats Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    children: [
                      _buildStatCard(
                        'Total students number',
                        _stats['total'].toString(),
                        Colors.blue,
                      ),
                      _buildStatCard(
                        'Average Attendance',
                        '${_stats['attendance']}%',
                        Colors.green,
                      ),
                      _buildStatCard(
                        'Total teachers number',
                        _stats['teachers'].toString(),
                        Colors.orange,
                      ),
                      _buildStatCard(
                        'Total courses number',
                        _stats['courses'].toString(),
                        Colors.purple,
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Teachers Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Teachers',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('View all teachers')),
                          );
                        },
                        child: Text(
                          'See all',
                          style: TextStyle(
                            color: Color(0xFF4F46E5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildTeachersList(),
                ],
              ),
            ),

            // PROFILE SECTION
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PROFILE',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),

                  // Profile Header
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xFF4F46E5),
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Admin User',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Administrator',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  // Profile Description
                  Text(
                    'Lorem Ipsum is simply dummy text of the standard dummy. '
                    'It has been the industry\'s standard dummy text ever since the 1500s.',
                    style: TextStyle(color: Colors.grey[700], height: 1.5),
                  ),

                  SizedBox(height: 20),

                  // Contact Info
                  _buildContactInfo('+213 567 34 57 88', Icons.phone),
                  SizedBox(height: 10),
                  _buildContactInfo('admin@gmail.com', Icons.email),

                  SizedBox(height: 20),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentManagementPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4F46E5),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: Icon(Icons.people),
                          label: Text('Manage Students'),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UploadFilesPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: Icon(Icons.upload_file),
                          label: Text('Upload Files'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Actions
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quick Actions',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh, size: 20),
                        onPressed: _loadStatistics,
                        tooltip: 'Refresh Dashboard',
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      // 1. Approve Registrations
                      _buildQuickAction(
                        'Approve Registrations',
                        Icons.check_circle,
                        Colors.green,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ApproveRegistrationsPage(),
                            ),
                          );
                        },
                      ),

                      // 2. Add Student
                      _buildQuickAction(
                        'Add Student',
                        Icons.person_add,
                        Colors.blue,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddStudentPage(),
                            ),
                          );
                        },
                      ),

                      // 3. Assign Courses
                      _buildQuickAction(
                        'Assign Courses',
                        Icons.class_,
                        Colors.orange,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AssignCoursesPage(),
                            ),
                          );
                        },
                      ),

                      // 4. Schedule
                      _buildQuickAction(
                        'Schedule',
                        Icons.calendar_today,
                        Colors.purple,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SchedulePage(),
                            ),
                          );
                        },
                      ),

                      // 5. Send Notification
                      _buildQuickAction(
                        'Send Notification',
                        Icons.notifications,
                        Colors.red,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SendNotificationPage(),
                            ),
                          );
                        },
                      ),

                      // 6. View Reports
                      _buildQuickAction(
                        'View Reports',
                        Icons.analytics,
                        Colors.teal,
                        () {
                         
                          
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Color(0xFF4F46E5),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Teachers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Already on dashboard
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentManagementPage(),
                ),
              );
              break;
            case 2:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Teachers page coming soon')),
              );
              break;
            case 3:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Settings page coming soon')),
              );
              break;
          }
        },
      ),
    );
  }
}