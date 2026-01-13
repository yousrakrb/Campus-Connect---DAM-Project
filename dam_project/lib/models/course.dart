// lib/models/course.dart
class Course {
  final String? id;
  final String courseId;
  final String title;
  final String description;
  final String teacherId;
  final String className;
  final String subject;
  final DateTime startDate;
  final DateTime endDate;
  final List<Assignment> assignments;
  final List<String> enrolledStudents;

  Course({
    this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.teacherId,
    required this.className,
    required this.subject,
    required this.startDate,
    required this.endDate,
    this.assignments = const [],
    this.enrolledStudents = const [],
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id']?.toString(),
      courseId: json['course_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      teacherId: json['teacher_id'] ?? '',
      className: json['class_name'] ?? '',
      subject: json['subject'] ?? '',
      startDate: DateTime.parse(json['start_date'] ?? DateTime.now().toIso8601String()),
      endDate: DateTime.parse(json['end_date'] ?? DateTime.now().toIso8601String()),
      assignments: List<Assignment>.from((json['assignments'] ?? []).map((x) => Assignment.fromJson(x))),
      enrolledStudents: List<String>.from(json['enrolled_students'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'course_id': courseId,
      'title': title,
      'description': description,
      'teacher_id': teacherId,
      'class_name': className,
      'subject': subject,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'assignments': assignments.map((x) => x.toJson()).toList(),
      'enrolled_students': enrolledStudents,
    };
  }
}

class Assignment {
  final String? id;
  final String title;
  final String description;
  final DateTime dueDate;
  final int totalPoints;
  final Map<String, double>? grades; // studentId -> grade
  final bool isPublished;

  Assignment({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.totalPoints,
    this.grades,
    this.isPublished = false,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id']?.toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      dueDate: DateTime.parse(json['due_date'] ?? DateTime.now().toIso8601String()),
      totalPoints: json['total_points'] as int? ?? 100,
      grades: Map<String, double>.from(json['grades'] ?? {}),
      isPublished: json['is_published'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'due_date': dueDate.toIso8601String(),
      'total_points': totalPoints,
      if (grades != null) 'grades': grades,
      'is_published': isPublished,
    };
  }

  // Calculate grading progress
  double get gradingProgress {
    if (grades == null || grades!.isEmpty) return 0.0;
    return grades!.length / totalPoints;
  }
}