// lib/models/teacher.dart
class Teacher {
  final String? id;
  final String? teacherId;
  final String name;
  final String email;
  final String department;
  final String? phone;
  final List<String> subjects;
  final List<String> assignedClasses;
  final DateTime? createdAt;
  final String? profileImage;
  final String? qualification;
  final int? experienceYears;

  Teacher({
    this.id,
    this.teacherId,
    required this.name,
    required this.email,
    required this.department,
    this.phone,
    required this.subjects,
    required this.assignedClasses,
    this.createdAt,
    this.profileImage,
    this.qualification,
    this.experienceYears,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id']?.toString(),
      teacherId: json['teacher_id']?.toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      department: json['department'] ?? '',
      phone: json['phone']?.toString(),
      subjects: List<String>.from(json['subjects'] ?? []),
      assignedClasses: List<String>.from(json['assigned_classes'] ?? []),
      createdAt: json['created_at'] != null 
          ? DateTime.tryParse(json['created_at'].toString()) 
          : null,
      profileImage: json['profile_image']?.toString(),
      qualification: json['qualification']?.toString(),
      experienceYears: json['experience_years'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (teacherId != null) 'teacher_id': teacherId,
      'name': name,
      'email': email,
      'department': department,
      if (phone != null) 'phone': phone,
      'subjects': subjects,
      'assigned_classes': assignedClasses,
      'created_at': createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      if (profileImage != null) 'profile_image': profileImage,
      if (qualification != null) 'qualification': qualification,
      if (experienceYears != null) 'experience_years': experienceYears,
    };
  }

  Teacher copyWith({
    String? id,
    String? teacherId,
    String? name,
    String? email,
    String? department,
    String? phone,
    List<String>? subjects,
    List<String>? assignedClasses,
    DateTime? createdAt,
    String? profileImage,
    String? qualification,
    int? experienceYears,
  }) {
    return Teacher(
      id: id ?? this.id,
      teacherId: teacherId ?? this.teacherId,
      name: name ?? this.name,
      email: email ?? this.email,
      department: department ?? this.department,
      phone: phone ?? this.phone,
      subjects: subjects ?? this.subjects,
      assignedClasses: assignedClasses ?? this.assignedClasses,
      createdAt: createdAt ?? this.createdAt,
      profileImage: profileImage ?? this.profileImage,
      qualification: qualification ?? this.qualification,
      experienceYears: experienceYears ?? this.experienceYears,
    );
  }

  // Helper method for teacher dashboard
  String get initials => name.isNotEmpty 
      ? name.split(' ').map((n) => n[0]).take(2).join().toUpperCase()
      : 'T';
}