// lib/screens/upload_files_page.dart
import 'package:flutter/material.dart';

class UploadFilesPage extends StatelessWidget {
  const UploadFilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Files'),
        backgroundColor: Color.fromARGB(255, 22, 17, 121),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload Schedule/Timetable',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            
            // File Upload Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_upload,
                      size: 60,
                      color: Color.fromARGB(255, 22, 17, 121),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Drag & drop files here',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'or',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 22, 17, 121),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      ),
                      child: Text('Browse Files'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}