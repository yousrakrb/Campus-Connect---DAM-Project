// lib/screens/send_notification_page.dart
import 'package:flutter/material.dart';

class SendNotificationPage extends StatefulWidget {
  const SendNotificationPage({super.key});

  @override
  State<SendNotificationPage> createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends State<SendNotificationPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _selectedAudience = 'all';
  List<String> _audienceOptions = ['all', 'students', 'teachers', 'parents'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Notification'),
        backgroundColor: Color.fromARGB(255, 22, 17, 121),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send Notification',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            
            // Audience Selection
            DropdownButtonFormField<String>(
              value: _selectedAudience,
              decoration: InputDecoration(
                labelText: 'Send to',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.group),
              ),
              items: _audienceOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option.toUpperCase()),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() => _selectedAudience = newValue);
                }
              },
            ),
            SizedBox(height: 20),
            
            // Title
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Notification Title',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
            ),
            SizedBox(height: 20),
            
            // Message
            TextFormField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.message),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 30),
            
            // Send Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isEmpty || _messageController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields')),
                    );
                    return;
                  }
                  
                  // Simulate sending notification
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Notification sent to $_selectedAudience'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  
                  // Clear form
                  _titleController.clear();
                  _messageController.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 22, 17, 121),
                ),
                child: Text('Send Notification', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
