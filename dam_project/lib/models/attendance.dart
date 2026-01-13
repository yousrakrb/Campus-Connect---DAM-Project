// lib/models/attendance.dart
import 'package:flutter/material.dart';

class Attendance {
  final String? id;
  final String studentId;
  final String courseId;
  final DateTime date;
  final bool isPresent;
  final String? remarks;
  final String markedBy; // teacher ID
  final String className; // NEW: Added for teacher dashboard
  final String subject;   // NEW: Added for teacher dashboard
  final AttendanceStatus status; // NEW: Replaces isPresent with more options
  final DateTime? markedAt; // NEW: When attendance was marked

  Attendance({
    this.id,
    required this.studentId,
    required this.courseId,
    required this.date,
    required this.isPresent,
    this.remarks,
    required this.markedBy,
    this.className = '', // Initialize new fields
    this.subject = '',
    this.status = AttendanceStatus.present, // Default to present
    this.markedAt,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    // Handle old format with isPresent and new format with status
    bool isPresent = json['is_present'] ?? false;
    AttendanceStatus status;
    
    if (json['status'] != null) {
      // New format with status enum
      status = AttendanceStatus.values.firstWhere(
        (e) => e.toString() == 'AttendanceStatus.${json['status']}',
        orElse: () => isPresent ? AttendanceStatus.present : AttendanceStatus.absent,
      );
    } else {
      // Old format - convert isPresent to status
      status = isPresent ? AttendanceStatus.present : AttendanceStatus.absent;
    }
    
    return Attendance(
      id: json['id']?.toString(),
      studentId: json['student_id'] ?? '',
      courseId: json['course_id'] ?? '',
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : DateTime.now(),
      isPresent: isPresent,
      remarks: json['remarks'],
      markedBy: json['marked_by'] ?? '',
      className: json['class_name'] ?? '',
      subject: json['subject'] ?? '',
      status: status,
      markedAt: json['marked_at'] != null ? DateTime.parse(json['marked_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'student_id': studentId,
      'course_id': courseId,
      'date': date.toIso8601String(),
      'is_present': isPresent, // Keep for backward compatibility
      'status': status.toString().split('.').last, // Add new status field
      if (remarks != null) 'remarks': remarks,
      'marked_by': markedBy,
      'class_name': className,
      'subject': subject,
      if (markedAt != null) 'marked_at': markedAt!.toIso8601String(),
    };
  }

  // Copy with method for updating
  Attendance copyWith({
    String? id,
    String? studentId,
    String? courseId,
    DateTime? date,
    bool? isPresent,
    String? remarks,
    String? markedBy,
    String? className,
    String? subject,
    AttendanceStatus? status,
    DateTime? markedAt,
  }) {
    return Attendance(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      courseId: courseId ?? this.courseId,
      date: date ?? this.date,
      isPresent: isPresent ?? this.isPresent,
      remarks: remarks ?? this.remarks,
      markedBy: markedBy ?? this.markedBy,
      className: className ?? this.className,
      subject: subject ?? this.subject,
      status: status ?? this.status,
      markedAt: markedAt ?? this.markedAt,
    );
  }

  // Helper method to convert status to boolean for UI compatibility
  bool get isPresentBool {
    return status == AttendanceStatus.present;
  }

  // Date formatting helper
  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Day name helper
  String get dayName {
    switch (date.weekday) {
      case 1: return 'Monday';
      case 2: return 'Tuesday';
      case 3: return 'Wednesday';
      case 4: return 'Thursday';
      case 5: return 'Friday';
      case 6: return 'Saturday';
      case 7: return 'Sunday';
      default: return '';
    }
  }
}

// Extended AttendanceStatus enum for teacher dashboard
enum AttendanceStatus {
  present,
  absent,
  late,
  excused,
  halfDay,
}

// Extension for UI helpers
extension AttendanceStatusExtension on AttendanceStatus {
  String get displayName {
    switch (this) {
      case AttendanceStatus.present: return 'Present';
      case AttendanceStatus.absent: return 'Absent';
      case AttendanceStatus.late: return 'Late';
      case AttendanceStatus.excused: return 'Excused';
      case AttendanceStatus.halfDay: return 'Half Day';
    }
  }

  String get shortName {
    switch (this) {
      case AttendanceStatus.present: return 'P';
      case AttendanceStatus.absent: return 'A';
      case AttendanceStatus.late: return 'L';
      case AttendanceStatus.excused: return 'E';
      case AttendanceStatus.halfDay: return 'H';
    }
  }

  Color get color {
    switch (this) {
      case AttendanceStatus.present: return Colors.green;
      case AttendanceStatus.absent: return Colors.red;
      case AttendanceStatus.late: return Colors.orange;
      case AttendanceStatus.excused: return Colors.blue;
      case AttendanceStatus.halfDay: return Colors.purple;
    }
  }

  IconData get icon {
    switch (this) {
      case AttendanceStatus.present: return Icons.check_circle;
      case AttendanceStatus.absent: return Icons.cancel;
      case AttendanceStatus.late: return Icons.access_time;
      case AttendanceStatus.excused: return Icons.event_available;
      case AttendanceStatus.halfDay: return Icons.hourglass_bottom;
    }
  }

  // For teacher dashboard attendance marking
  Color get buttonColor {
    switch (this) {
      case AttendanceStatus.present: return Colors.green.withOpacity(0.2);
      case AttendanceStatus.absent: return Colors.red.withOpacity(0.2);
      case AttendanceStatus.late: return Colors.orange.withOpacity(0.2);
      case AttendanceStatus.excused: return Colors.blue.withOpacity(0.2);
      case AttendanceStatus.halfDay: return Colors.purple.withOpacity(0.2);
    }
  }

  Color get textColor {
    switch (this) {
      case AttendanceStatus.present: return Colors.green;
      case AttendanceStatus.absent: return Colors.red;
      case AttendanceStatus.late: return Colors.orange;
      case AttendanceStatus.excused: return Colors.blue;
      case AttendanceStatus.halfDay: return Colors.purple;
    }
  }
}

// Helper class for attendance statistics (used in teacher dashboard)
class AttendanceStats {
  final String className;
  final String subject;
  final int totalStudents;
  final int presentCount;
  final int absentCount;
  final int lateCount;
  final int excusedCount;
  final DateTime date;
  final double attendancePercentage;

  AttendanceStats({
    required this.className,
    required this.subject,
    required this.totalStudents,
    required this.presentCount,
    required this.absentCount,
    required this.lateCount,
    required this.excusedCount,
    required this.date,
  }) : attendancePercentage = totalStudents > 0 
        ? ((presentCount + (lateCount * 0.5)) / totalStudents) * 100 
        : 0.0;

  // Color based on attendance percentage
  Color get percentageColor {
    if (attendancePercentage >= 90) return Colors.green;
    if (attendancePercentage >= 80) return Colors.lightGreen;
    if (attendancePercentage >= 70) return Colors.yellow;
    if (attendancePercentage >= 60) return Colors.orange;
    return Colors.red;
  }
}