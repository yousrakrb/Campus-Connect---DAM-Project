import 'package:flutter/material.dart';

class StudentScheduleScreen extends StatefulWidget {
  const StudentScheduleScreen({Key? key}) : super(key: key);

  @override
  _StudentScheduleScreenState createState() => _StudentScheduleScreenState();
}

class _StudentScheduleScreenState extends State<StudentScheduleScreen> {
  final Color primaryColor = Color(0xFF4361EE);
  final Color backgroundColor = Color(0xFFF5F7FB);
  
  DateTime selectedDate = DateTime.now();
  String viewMode = 'week';
  
  // Day names for display
  final List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  
  List<Map<String, dynamic>> scheduleData = [
    {
      'day': 'Monday',
      'courses': [
        {'time': '09:00 - 10:30', 'name': 'TEC', 'room': 'Room 01', 'teacher': 'Dr. Sediki', 'type': 'Lecture', 'color': Colors.blue},
        {'time': '11:00 - 12:30', 'name': 'DAW', 'room': 'Lab 4', 'teacher': 'Prof. Mouradi', 'type': 'Lab', 'color': Colors.green},
        {'time': '14:00 - 15:30', 'name': 'BDM', 'room': 'Room 05', 'teacher': 'Dr. Sediki', 'type': 'Lecture', 'color': Colors.orange},
      ],
    },
    {
      'day': 'Tuesday',
      'courses': [
        {'time': '10:00 - 11:30', 'name': 'OTAM', 'room': 'Room ', 'teacher': 'Prof. Miloudi', 'type': 'Lecture', 'color': Colors.purple},
        {'time': '13:00 - 14:30', 'name': 'Web Development', 'room': 'Lab 3', 'teacher': 'Dr. Mihoub', 'type': 'Lab', 'color': Colors.teal},
      ],
    },
    {
      'day': 'Wednesday',
      'courses': [
        {'time': '14:00 - 15:30', 'name': 'BDM', 'room': 'Room 05', 'teacher': 'Dr. Sediki', 'type': 'Lecture', 'color': Colors.orange},
        {'time': '11:00 - 12:30', 'name': 'GL',  'room': 'Room 208', 'teacher': 'Prof. Lezzar', 'type': 'Lecture', 'color': Colors.pink},
      ],
    },
    {
      'day': 'Thursday',
      'courses': [
        {'time': '10:00 - 11:30', 'name': 'OTAM', 'room': 'Room ', 'teacher': 'Prof. Miloudi', 'type': 'Lecture', 'color': Colors.purple},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('My Schedule'),
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.view_week_outlined, color: Colors.white),
            onSelected: (value) => setState(() => viewMode = value),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'day',
                child: Row(
                  children: [
                    Icon(Icons.view_day_outlined, size: 20),
                    SizedBox(width: 10),
                    Text('Day View'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'week',
                child: Row(
                  children: [
                    Icon(Icons.view_week_outlined, size: 20),
                    SizedBox(width: 10),
                    Text('Week View'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'month',
                child: Row(
                  children: [
                    Icon(Icons.calendar_view_month_outlined, size: 20),
                    SizedBox(width: 10),
                    Text('Month View'),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.download_outlined, color: Colors.white),
            onPressed: _exportSchedule,
          ),
        ],
      ),
      body: Column(
        children: [
          // Date Selector
          _buildDateSelector(),
          SizedBox(height: 8),
          
          // View Mode Chips
          _buildViewModeChips(),
          SizedBox(height: 16),
          
          // Schedule Content
          Expanded(
            child: _buildScheduleContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    // Get day name and formatted date without DateFormat
    String dayName = _getDayName(selectedDate.weekday);
    String monthName = _getMonthName(selectedDate.month);
    String formattedDate = '$monthName ${selectedDate.day}, ${selectedDate.year}';
    
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => setState(() => selectedDate = selectedDate.subtract(Duration(days: 1))),
          ),
          Column(
            children: [
              Text(
                dayName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2B2B2B),
                ),
              ),
              Text(
                formattedDate,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () => setState(() => selectedDate = selectedDate.add(Duration(days: 1))),
          ),
        ],
      ),
    );
  }

  String _getDayName(int weekday) {
    // Weekday: 1=Monday, 7=Sunday
    return days[weekday - 1];
  }

  String _getMonthName(int month) {
    // Month: 1=January, 12=December
    return months[month - 1];
  }

  Widget _buildViewModeChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildChip('Today', viewMode == 'day'),
          SizedBox(width: 8),
          _buildChip('This Week', viewMode == 'week'),
          SizedBox(width: 8),
          _buildChip('This Month', viewMode == 'month'),
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool selected) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (bool value) {
        setState(() {
          viewMode = label.toLowerCase().split(' ')[1];
        });
      },
      selectedColor: primaryColor,
      labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
    );
  }

  Widget _buildScheduleContent() {
    if (viewMode == 'day') return _buildDayView();
    if (viewMode == 'week') return _buildWeekView();
    return _buildMonthView();
  }

  Widget _buildDayView() {
    // Get current day name
    String selectedDay = _getDayName(selectedDate.weekday);
    
    // Find schedule for this day
    var daySchedule = scheduleData.firstWhere(
      (day) => day['day'] == selectedDay,
      orElse: () => {'day': selectedDay, 'courses': []},
    );
    
    List courses = daySchedule['courses'] ?? [];

    if (courses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_available_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'No classes scheduled',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            Text(
              'Enjoy your day off!',
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
      itemCount: courses.length,
      itemBuilder: (context, index) => _buildClassCard(courses[index]),
    );
  }

  Widget _buildWeekView() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: scheduleData.length,
      itemBuilder: (context, index) {
        var dayData = scheduleData[index];
        List courses = dayData['courses'] ?? [];

        return Card(
          margin: EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      dayData['day'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2B2B2B),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${courses.length} ${courses.length == 1 ? 'class' : 'classes'}',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                if (courses.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'No classes scheduled',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ...courses.map((course) => _buildClassCard(course)).toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMonthView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_view_month_outlined,
              size: 80,
              color: primaryColor.withOpacity(0.3),
            ),
            SizedBox(height: 16),
            Text(
              'Monthly Calendar View',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2B2B2B),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Coming soon...',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() => viewMode = 'week'),
              child: Text('Switch to Week View'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassCard(Map<String, dynamic> course) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      color: course['color'].withOpacity(0.05),
      child: ListTile(
        leading: Container(
          width: 4,
          color: course['color'],
        ),
        title: Text(
          course['name'],
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${course['code']} • ${course['teacher']}'),
            Text(course['room']),
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: course['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                course['type'],
                style: TextStyle(
                  color: course['color'],
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        trailing: Text(
          course['time'],
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        onTap: () {
          _showClassDetails(course);
        },
      ),
    );
  }

  void _showClassDetails(Map<String, dynamic> course) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 40,
                    decoration: BoxDecoration(
                      color: course['color'],
                      borderRadius: BorderRadius.circular(4),
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          course['code'],
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildDetailRow(Icons.schedule, 'Time', course['time']),
              _buildDetailRow(Icons.place, 'Room', course['room']),
              _buildDetailRow(Icons.person, 'Instructor', course['teacher']),
              _buildDetailRow(Icons.category, 'Type', course['type']),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Close'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
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

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _exportSchedule() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Schedule exported successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }
}