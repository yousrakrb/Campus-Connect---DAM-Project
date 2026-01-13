// lib/screens/teacher_schedule_page.dart
import 'package:flutter/material.dart';

class TeacherSchedulePage extends StatefulWidget {
  const TeacherSchedulePage({super.key});

  @override
  State<TeacherSchedulePage> createState() => _TeacherSchedulePageState();
}

class _TeacherSchedulePageState extends State<TeacherSchedulePage> {
  List<Map<String, dynamic>> _weeklySchedule = [
    {'day': 'Mon', 'sessions': [
      {'time': '08:00-09:30', 'subject': 'Math', 'class': 'L1(G5)', 'room': '1'},
      {'time': '10:00-11:30', 'subject': 'Physics', 'class': 'L1(G3)', 'room': '2'},
    ]},
    {'day': 'Tue', 'sessions': [
      {'time': '09:00-10:30', 'subject': 'Math', 'class': 'L2(G12)', 'room': '3'},
    ]},
    {'day': 'Wed', 'sessions': [
      {'time': '08:00-09:30', 'subject': 'Math ', 'class': 'L2(G14)', 'room': 'Lab 1'},
    ]},
  ];
  String _selectedDay = 'Mon';

  Widget _buildDaySelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(15),
      child: Row(
        children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map((day) {
          final isSelected = _selectedDay == day;
          return GestureDetector(
            onTap: () => setState(() => _selectedDay = day),
            child: Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.purple : Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? Colors.purple : Colors.grey[300]!),
              ),
              child: Text(day, style: TextStyle(color: isSelected ? Colors.white : Colors.grey[700])),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSessionCard(Map<String, dynamic> session) {
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
          Container(width: 4, height: 60, decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(2))),
          SizedBox(width: 15),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(session['subject'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 5),
            Row(children: [
              Icon(Icons.access_time, size: 14, color: Colors.grey[600]), SizedBox(width: 5), Text(session['time']),
              SizedBox(width: 15),
              Icon(Icons.class_, size: 14, color: Colors.grey[600]), SizedBox(width: 5), Text(session['class']),
            ]),
          ])),
          Chip(label: Text('Room ${session['room']}'), backgroundColor: Colors.purple.withOpacity(0.1)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final daySchedule = _weeklySchedule.firstWhere((day) => day['day'] == _selectedDay, orElse: () => {'sessions': []});
    
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text('My Schedule'),
        backgroundColor: Colors.purple,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        children: [
          _buildDaySelector(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: (daySchedule['sessions'] as List).isEmpty
                  ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.event_available, size: 60, color: Colors.grey[300]),
                      SizedBox(height: 10),
                      Text('No classes on $_selectedDay', style: TextStyle(color: Colors.grey[600])),
                    ]))
                  : ListView(
                      children: (daySchedule['sessions'] as List<dynamic>).map((session) => _buildSessionCard(session)).toList(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}