import 'package:flutter/material.dart';

class StudentGradesScreen extends StatefulWidget {
  const StudentGradesScreen({Key? key}) : super(key: key);

  @override
  _StudentGradesScreenState createState() => _StudentGradesScreenState();
}

class _StudentGradesScreenState extends State<StudentGradesScreen> {
  final Color primaryColor = Color(0xFF4361EE);
  final Color backgroundColor = Color(0xFFF5F7FB);
  
  List<String> semesters = ['2024', 'Semester 1', 'All Courses'];
  String selectedSemester = '2024';
  
  List<Map<String, dynamic>> courses = [
    {
      'id': 'CS201',
      'name': 'Algorithmic',
      'instructor': 'Dr. Bahloul',
      'credits': 3,
      'grade': 89,
      'letter': 'A-',
      'color': Colors.blue,
      'assessments': [
        {'name': 'Assignment 1', 'weight': '10%', 'score': '18/20'},
        {'name': 'Assignment 2', 'weight': '10%', 'score': '19/20'},
        {'name': 'Midterm Exam', 'weight': '30%', 'score': '45/50'},
        {'name': 'Final Exam', 'weight': '50%', 'score': '85/100'},
      ],
    },
    {
      'id': 'CS202',
      'name': 'Algorithms',
      'code': 'CS202',
      'instructor': 'Prof. Johnson',
      'credits': 3,
      'grade': 85,
      'letter': 'B+',
      'color': Colors.green,
      'assessments': [
        {'name': 'Lab 1', 'weight': '15%', 'score': '14/15'},
        {'name': 'Lab 2', 'weight': '15%', 'score': '13/15'},
        {'name': 'Project', 'weight': '20%', 'score': '38/40'},
        {'name': 'Final Exam', 'weight': '50%', 'score': '80/100'},
      ],
    },
    {
      'id': 'CS203',
      'name': 'Database',
      'instructor': 'Dr. Sahraoui',
      'credits': 4,
      'grade': 92,
      'letter': 'A',
      'color': Colors.orange,
      'assessments': [
        {'name': 'Quizzes', 'weight': '20%', 'score': '38/40'},
        {'name': 'Project', 'weight': '30%', 'score': '28/30'},
        {'name': 'Final Exam', 'weight': '50%', 'score': '92/100'},
      ],
    },
    
  ];

  double calculateGPA() {
    double totalPoints = 0;
    int totalCredits = 0;
    
    for (var course in courses) {
      int credits = course['credits'];
      double grade = course['grade'].toDouble();
      
      totalPoints += (grade / 20) * credits; // Convert percentage to 4.0 scale
      totalCredits += credits;
    }
    
    return totalCredits > 0 ? (totalPoints / totalCredits) : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final double gpa = calculateGPA();
    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('My Grades'),
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download_outlined, color: Colors.white),
            onPressed: _exportGrades,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // GPA Summary Card
            _buildGPASummary(gpa),
            SizedBox(height: 16),
            
            // Semester Filter
            _buildSemesterFilter(),
            SizedBox(height: 16),
            
            // Courses List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  for (var course in courses) _buildCourseCard(course),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildGPASummary(double gpa) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryColor, Color(0xFF3A0CA3)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Final Average',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  gpa.toStringAsFixed(2),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '14,07',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              _buildStatItem('Courses', '${courses.length}', Icons.school),
              SizedBox(height: 12),
              _buildStatItem('Credits', '13', Icons.credit_score),
              SizedBox(height: 12),
              _buildStatItem('Avg Grade', '86%', Icons.bar_chart),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSemesterFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Icon(Icons.filter_list, color: Colors.grey[600]),
          SizedBox(width: 8),
          Text(
            'Semester:',
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: semesters.map((semester) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(semester),
                      selected: selectedSemester == semester,
                      onSelected: (selected) {
                        setState(() {
                          selectedSemester = semester;
                        });
                      },
                      selectedColor: primaryColor,
                      labelStyle: TextStyle(
                        color: selectedSemester == semester ? Colors.white : Colors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: course['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
          
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course['name'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2B2B2B),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Prof. ${course['instructor']} • ${course['credits']} credits',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Chip(
                      label: Text(
                        course['letter'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: _getGradeColor(course['grade']),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${course['grade']}%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            LinearProgressIndicator(
              value: course['grade'] / 100,
              backgroundColor: Colors.grey[200],
              color: _getGradeColor(course['grade']),
            ),
            SizedBox(height: 12),
            // Assessment breakdown (simplified - you could make this expandable)
            Column(
              children: [
                for (var assessment in course['assessments'])
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            assessment['name'],
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Text(
                          assessment['weight'],
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        SizedBox(width: 16),
                        Text(
                          assessment['score'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getGradeColor(int grade) {
    if (grade >= 90) return Colors.green;
    if (grade >= 80) return Colors.lightGreen;
    if (grade >= 70) return Colors.orange;
    if (grade >= 60) return Colors.deepOrange;
    return Colors.red;
  }

  void _exportGrades() {
    // Implement grade export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exporting grades...'),
        backgroundColor: primaryColor,
      ),
    );
  }
}