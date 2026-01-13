import 'package:flutter/material.dart';
import 'student_announcement.dart';
import 'student_grades.dart';
import 'student_profile.dart';
import 'student_schedule.dart';
import 'student_setting.dart';

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({Key? key}) : super(key: key);

  @override
  _StudentDashboardScreenState createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  final String studentName = "Yousra";
  final int unreadNotifications = 3;

  // Colors matching Teacher/Admin dashboards
  final Color primaryColor = Color(0xFF4361EE);
  final Color backgroundColor = Color(0xFFF5F7FB);
  final Color textColor = Color(0xFF2B2B2B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Student Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColor,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_outlined, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentAnnouncementsScreen(),
                    ),
                  );
                },
              ),
              if (unreadNotifications > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Text(
                      '$unreadNotifications',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) => _handleMenuSelection(value, context),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'profile',
                  child: Row(
                    children: [
                      Icon(Icons.person_outline, size: 20),
                      SizedBox(width: 10),
                      Text('My Profile'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'settings',
                  child: Row(
                    children: [
                      Icon(Icons.settings_outlined, size: 20),
                      SizedBox(width: 10),
                      Text('Settings'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 20, color: Colors.red),
                      SizedBox(width: 10),
                      Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      drawer: _buildNavigationDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeCard(),
              SizedBox(height: 24),
              
              Text(
                'Quick Access',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              SizedBox(height: 12),
              _buildDashboardGrid(),
              SizedBox(height: 24),
              
              Text(
                'Today\'s Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              SizedBox(height: 12),
              _buildQuickInfoCard(),
              SizedBox(height: 24),
              
              _buildRecentActivity(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: primaryColor.withOpacity(0.1),
            child: Icon(
              Icons.person,
              size: 32,
              color: primaryColor,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  studentName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.school_outlined, size: 16, color: Colors.grey),
                    SizedBox(width: 6),
                    Text(
                      'Computer Science • Year 3',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

  Widget _buildDashboardGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildDashboardCard(
          Icons.schedule_outlined,
          'My Schedule',
          'View timetable',
          Color(0xFF4361EE),
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentScheduleScreen(),
            ),
          ),
        ),
        _buildDashboardCard(
          Icons.grade_outlined,
          'My Grades',
          'Check marks',
          Color(0xFF4CAF50),
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentGradesScreen(),
            ),
          ),
        ),
        _buildDashboardCard(
          Icons.person_outlined,
          'My Profile',
          'Edit details',
          Color(0xFFFF9800),
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentProfileScreen(),
            ),
          ),
        ),
        _buildDashboardCard(
          Icons.announcement_outlined,
          'Announcements',
          '$unreadNotifications unread',
          Color(0xFF9C27B0),
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentAnnouncementsScreen(),
            ),
          ),
        ),
        _buildDashboardCard(
          Icons.assignment_outlined,
          'Assignments',
          '2 pending',
          Color(0xFFFF5722),
          () => _showComingSoonDialog('Assignments'),
        ),
        _buildDashboardCard(
          Icons.settings_outlined,
          'Settings',
          'App preferences',
          Color(0xFF607D8B),
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentSettingsScreen(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardCard(IconData icon, String title, String subtitle, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              SizedBox(height: 12),
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: 4),
              Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildQuickInfoRow(
              Icons.schedule,
              Colors.blue,
              'Next Class',
              'Calculus ',
              '10:00 AM • Room 01',
            ),
            Divider(height: 20),
            _buildQuickInfoRow(
              Icons.grade,
              Colors.green,
              'Recent Grade',
              'OTAM Midterm: 85%',
              'Updated today',
            ),
            Divider(height: 20),
            _buildQuickInfoRow(
              Icons.assignment,
              Colors.orange,
              'Pending Assignments',
              '2 submissions due',
              'DAM & OTAM',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickInfoRow(IconData icon, Color color, String title, String value, String subtitle) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              SizedBox(height: 2),
              Text(value, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              Text(subtitle, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Activity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              TextButton(
                onPressed: () => _showComingSoonDialog('Activity'),
                child: Text('See All', style: TextStyle(color: primaryColor)),
              ),
            ],
          ),
          SizedBox(height: 8),
          _buildActivityItem(Icons.grade, Colors.green, 'Grade updated', 'OTAM Midterm: 85%', '2 hours ago'),
          Divider(height: 20),
          _buildActivityItem(Icons.announcement, Colors.blue, 'New announcement', 'Exam schedule released', 'Yesterday'),
          Divider(height: 20),
          _buildActivityItem(Icons.assignment, Colors.orange, 'Assignment reminder', 'DAM homework due tomorrow', '2 days ago'),
        ],
      ),
    );
  }

  Widget _buildActivityItem(IconData icon, Color color, String title, String subtitle, String time) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 2),
              Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
            ],
          ),
        ),
        Text(time, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
      ],
    );
  }

  Widget _buildNavigationDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: Icon(Icons.person, size: 32, color: Colors.white),
                  ),
                  SizedBox(height: 12),
                  Text(
                    studentName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Student • CS Year 3',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          _buildDrawerItem(Icons.dashboard_outlined, 'Dashboard', true, () => Navigator.pop(context)),
          _buildDrawerItem(Icons.schedule_outlined, 'Schedule', false, 
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => StudentScheduleScreen()))),
          _buildDrawerItem(Icons.grade_outlined, 'Grades', false, 
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => StudentGradesScreen()))),
          _buildDrawerItem(Icons.person_outlined, 'Profile', false, 
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => StudentProfileScreen()))),
          _buildDrawerItem(Icons.announcement_outlined, 'Announcements', false, 
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => StudentAnnouncementsScreen())), 
            badge: unreadNotifications),
          _buildDrawerItem(Icons.assignment_outlined, 'Assignments', false, 
            () => _showComingSoonDialog('Assignments')),
          _buildDrawerItem(Icons.download_outlined, 'Materials', false, 
            () => _showComingSoonDialog('Materials')),
          Divider(height: 20, indent: 20, endIndent: 20),
          _buildDrawerItem(Icons.settings_outlined, 'Settings', false, 
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => StudentSettingsScreen()))),
          _buildDrawerItem(Icons.help_outline, 'Help & Support', false, 
            () => _showComingSoonDialog('Help')),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton.icon(
              icon: Icon(Icons.logout, size: 18),
              label: Text('Logout'),
              onPressed: () => _handleLogout(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.1),
                foregroundColor: Colors.red,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, bool selected, VoidCallback onTap, {int badge = 0}) {
    return ListTile(
      leading: Icon(icon, color: selected ? primaryColor : Colors.grey[700]),
      title: Text(
        title,
        style: TextStyle(
          color: selected ? primaryColor : Colors.grey[700],
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: badge > 0
          ? Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$badge',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      onTap: onTap,
      tileColor: selected ? primaryColor.withOpacity(0.1) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      dense: true,
    );
  }

  void _handleMenuSelection(String value, BuildContext context) {
    switch (value) {
      case 'profile':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudentProfileScreen()),
        );
        break;
      case 'settings':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudentSettingsScreen()),
        );
        break;
      case 'logout':
        _handleLogout(context);
        break;
    }
  }

  void _showComingSoonDialog(String feature) {
    switch (feature.toLowerCase()) {
      case 'announcements':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentAnnouncementsScreen(),
          ),
        );
        break;
      case 'grades':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentGradesScreen(),
          ),
        );
        break;
      case 'profile':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentProfileScreen(),
          ),
        );
        break;
      case 'schedule':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentScheduleScreen(),
          ),
        );
        break;
      case 'settings':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentSettingsScreen(),
          ),
        );
        break;
      case 'assignments':
      case 'materials':
      case 'activity':
      default:
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('$feature Page'),
            content: Text('The $feature page will be available soon!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
    }
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}