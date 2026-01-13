// lib/models/grade.dart
import 'package:flutter/material.dart';

class Grade {
  final String? id;
  final String studentId;
  final String teacherId;
  final String assignmentId;
  final String className;
  final String subject;
  final double score;
  final double maxScore;
  final String? comments;
  final DateTime gradedDate;
  final GradeStatus status;

  Grade({
    this.id,
    required this.studentId,
    required this.teacherId,
    required this.assignmentId,
    required this.className,
    required this.subject,
    required this.score,
    required this.maxScore,
    this.comments,
    required this.gradedDate,
    required this.status,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id']?.toString(),
      studentId: json['student_id'] ?? '',
      teacherId: json['teacher_id'] ?? '',
      assignmentId: json['assignment_id'] ?? '',
      className: json['class_name'] ?? '',
      subject: json['subject'] ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      maxScore: (json['max_score'] as num?)?.toDouble() ?? 100.0,
      comments: json['comments']?.toString(),
      gradedDate: DateTime.parse(json['graded_date'] ?? DateTime.now().toIso8601String()),
      status: GradeStatus.values.firstWhere(
        (e) => e.toString() == 'GradeStatus.${json['status']}',
        orElse: () => GradeStatus.pending,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'student_id': studentId,
      'teacher_id': teacherId,
      'assignment_id': assignmentId,
      'class_name': className,
      'subject': subject,
      'score': score,
      'max_score': maxScore,
      if (comments != null) 'comments': comments,
      'graded_date': gradedDate.toIso8601String(),
      'status': status.toString().split('.').last,
    };
  }

  // Helper methods
  double get percentage => (score / maxScore) * 100;
  
  String get letterGrade {
    final percent = percentage;
    if (percent >= 90) return 'A';
    if (percent >= 80) return 'B';
    if (percent >= 70) return 'C';
    if (percent >= 60) return 'D';
    return 'F';
  }

  Color get gradeColor {
    final percent = percentage;
    if (percent >= 90) return Colors.green;
    if (percent >= 80) return Colors.lightGreen;
    if (percent >= 70) return Colors.yellow;
    if (percent >= 60) return Colors.orange;
    return Colors.red;
  }
}

enum GradeStatus {
  pending,
  graded,
  published,
  revised,
}