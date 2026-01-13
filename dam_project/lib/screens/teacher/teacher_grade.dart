// lib/screens/teacher_grading_page.dart
import 'package:flutter/material.dart';

class TeacherGradingPage extends StatefulWidget {
  const TeacherGradingPage({super.key});

  @override
  State<TeacherGradingPage> createState() => _TeacherGradingPageState();
}

class _TeacherGradingPageState extends State<TeacherGradingPage> {
  List<Map<String, dynamic>> _assignments = [
    {'title': 'Algebra Test', 'class': 'L1', 'due': '15 Jan', 'graded': 15, 'total': 30},
    {'title': 'Calculus Test', 'class': 'L1', 'due': '18 Jan', 'graded': 10, 'total': 25},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text('Grading'),
        backgroundColor: Colors.orange,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})],
      ),
      body: Column(
        children: [
          // Stats
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Column(children: [
                Text('24', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange)),
                Text('Pending', style: TextStyle(color: Colors.grey[600])),
              ]),
              Column(children: [
                Text('156', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green)),
                Text('Graded', style: TextStyle(color: Colors.grey[600])),
              ]),
              Column(children: [
                Text('3', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue)),
                Text('Assignments', style: TextStyle(color: Colors.grey[600])),
              ]),
            ]),
          ),
          
          // Assignments List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: _assignments.length,
              itemBuilder: (context, index) {
                final assignment = _assignments[index];
                final progress = assignment['graded'] / assignment['total'];
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(assignment['title'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Chip(label: Text(assignment['class']), backgroundColor: Colors.orange.withOpacity(0.1)),
                      ]),
                      SizedBox(height: 10),
                      Row(children: [
                        Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                        SizedBox(width: 5),
                        Text('Due: ${assignment['due']}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                        Spacer(),
                        Text('${assignment['graded']}/${assignment['total']} graded', style: TextStyle(fontSize: 12)),
                      ]),
                      SizedBox(height: 10),
                      LinearProgressIndicator(value: progress, color: Colors.orange),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 40),
                        ),
                        child: Text('Enter Grades'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}