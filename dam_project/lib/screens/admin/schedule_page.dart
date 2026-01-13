// lib/screens/schedule_page.dart
import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Management'),
        backgroundColor: Color.fromARGB(255, 22, 17, 121),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today, size: 80, color: Colors.grey[300]),
            SizedBox(height: 20),
            Text(
              'Class Schedule',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Manage timetables and schedules',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement schedule management
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Schedule management coming soon!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 22, 17, 121),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text('View Timetable'),
            ),
          ],
        ),
      ),
    );
  }
}
