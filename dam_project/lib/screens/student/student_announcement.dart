import 'package:flutter/material.dart';

class StudentAnnouncementsScreen extends StatefulWidget {
  const StudentAnnouncementsScreen({Key? key}) : super(key: key);

  @override
  _StudentAnnouncementsScreenState createState() => _StudentAnnouncementsScreenState();
}

class _StudentAnnouncementsScreenState extends State<StudentAnnouncementsScreen> {
  final Color primaryColor = Color(0xFF4361EE);
  final Color backgroundColor = Color(0xFFF5F7FB);
  
  List<String> filters = ['All', 'Unread', 'Important', 'Courses'];
  String selectedFilter = 'All';
  
  List<Map<String, dynamic>> announcements = [
    {
      'id': '1',
      'title': 'Final Exam Schedule Released',
      'message': 'The final exam schedule has been published. Please check your course pages for specific dates and times.',
      'sender': 'Registrar Office',
      'date': '2 hours ago',
      'read': false,
      'important': true,
    },
    {
      'id': '2',
      'title': 'Assignment Submission Deadline Extended',
      'message': 'DDL extended to Friday, 5 PM due to technical issues.',
      'sender': 'Dr. Sediki',
      'date': 'Yesterday',
      'read': true,
      'important': false,
    },
   
    {
      'id': '4',
      'title': 'Midterm Grades Available',
      'message': 'Midterm grades for Algorithms course are now available. Please check the grades section.',
      'sender': 'Prof. Sahraoui ',
      'date': '3 days ago',
      'read': true,
      'important': false,
    },
    {
      'id': '5',
      'title': 'Project Submission Guidelines',
      'message': 'Please review the updated project submission guidelines on the course page. Late submissions will not be counted.',
      'sender': 'Dr. Miroud ',
      'date': '4 days ago',
      'read': false,
      'important': false,
    },
  ];

  List<Map<String, dynamic>> get filteredAnnouncements {
    if (selectedFilter == 'All') return announcements;
    if (selectedFilter == 'Unread') return announcements.where((a) => !a['read']).toList();
    if (selectedFilter == 'Important') return announcements.where((a) => a['important']).toList();
    if (selectedFilter == 'Courses') return announcements.where((a) => a['course'] != null).toList();
    return announcements;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Announcements'),
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.mark_email_read, color: Colors.white),
            onPressed: _markAllAsRead,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          _buildFilterChips(),
          SizedBox(height: 8),
          
          // Stats
          _buildStatsRow(),
          SizedBox(height: 16),
          
          // Announcements List
          Expanded(
            child: _buildAnnouncementsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((filter) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FilterChip(
                label: Text(filter),
                selected: selectedFilter == filter,
                onSelected: (selected) {
                  setState(() {
                    selectedFilter = filter;
                  });
                },
                selectedColor: primaryColor,
                labelStyle: TextStyle(
                  color: selectedFilter == filter ? Colors.white : Colors.black,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    int unreadCount = announcements.where((a) => !a['read']).length;
    int importantCount = announcements.where((a) => a['important']).length;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          _buildStatChip('$unreadCount Unread', Icons.mark_email_unread, primaryColor),
          SizedBox(width: 8),
          _buildStatChip('$importantCount Important', Icons.priority_high, Colors.orange),
          SizedBox(width: 8),
          _buildStatChip('${announcements.length} Total', Icons.email, Colors.green),
        ],
      ),
    );
  }

  Widget _buildStatChip(String text, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementsList() {
    if (filteredAnnouncements.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.announcement_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'No announcements',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            Text(
              'Check back later for updates',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: filteredAnnouncements.length,
      itemBuilder: (context, index) {
        final announcement = filteredAnnouncements[index];
        return _buildAnnouncementCard(announcement);
      },
    );
  }

  Widget _buildAnnouncementCard(Map<String, dynamic> announcement) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            announcement['read'] = true;
          });
          _showAnnouncementDetails(announcement);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (announcement['important'])
                              Icon(Icons.priority_high, size: 16, color: Colors.orange),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                announcement['title'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2B2B2B),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          announcement['sender'],
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!announcement['read'])
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                announcement['message'],
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (announcement['course'] != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        announcement['course'],
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  Text(
                    announcement['date'],
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),   
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAnnouncementDetails(Map<String, dynamic> announcement) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (announcement['important'])
                    Icon(Icons.priority_high, color: Colors.orange),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      announcement['title'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                announcement['sender'],
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                announcement['message'],
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    announcement['date'],
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Close'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
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

  void _markAllAsRead() {
    setState(() {
      for (var announcement in announcements) {
        announcement['read'] = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('All announcements marked as read'),
        backgroundColor: primaryColor,
      ),
    );
  }
}