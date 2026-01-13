// lib/models/mark.dart
class Mark {
  final String? id;
  final String studentId;
  final String courseId;
  final String examType; // 'midterm', 'final', 'quiz1', 'assignment'
  final double marks;
  final double maxMarks; // Usually 20, 100, etc.
  final DateTime examDate;
  final String? remarks;
  final String addedBy; // teacher ID

  Mark({
    this.id,
    required this.studentId,
    required this.courseId,
    required this.examType,
    required this.marks,
    this.maxMarks = 20,
    required this.examDate,
    this.remarks,
    required this.addedBy,
  });

  factory Mark.fromJson(Map<String, dynamic> json) {
    return Mark(
      id: json['id']?.toString(),
      studentId: json['student_id'] ?? '',
      courseId: json['course_id'] ?? '',
      examType: json['exam_type'] ?? 'midterm',
      marks: json['marks'] != null 
          ? double.parse(json['marks'].toString())
          : 0,
      maxMarks: json['max_marks'] != null
          ? double.parse(json['max_marks'].toString())
          : 20,
      examDate: json['exam_date'] != null
          ? DateTime.parse(json['exam_date'])
          : DateTime.now(),
      remarks: json['remarks'],
      addedBy: json['added_by'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'student_id': studentId,
      'course_id': courseId,
      'exam_type': examType,
      'marks': marks,
      'max_marks': maxMarks,
      'exam_date': examDate.toIso8601String(),
      if (remarks != null) 'remarks': remarks,
      'added_by': addedBy,
    };
  }

  double get percentage => (marks / maxMarks) * 100;
  String get grade {
    if (percentage >= 90) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B';
    if (percentage >= 60) return 'C';
    if (percentage >= 50) return 'D';
    return 'F';
  }
}