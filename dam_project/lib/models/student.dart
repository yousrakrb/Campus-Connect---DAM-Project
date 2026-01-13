// lib/models/student.dart
class Student {
  final String? id;
  final String? studentId;
  final String name;
  final String email;
  final String group;
  final String? phone;
  final String status;
  final DateTime? createdAt;
  
  
  Student({
    this.id,
    this.studentId,
    required this.name,
    required this.email,
    required this.group,
    this.phone,
    this.status = 'pending',
    this.createdAt,
  });

  // Generate unique ID if not provided
  String get effectiveId => id ?? DateTime.now().millisecondsSinceEpoch.toString();
  
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id']?.toString(),
      studentId: json['student_id']?.toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      group: json['group'] ?? '',
      phone: json['phone']?.toString(),
      status: json['status'] ?? 'pending',
      createdAt: json['created_at'] != null 
          ? DateTime.tryParse(json['created_at'].toString()) 
          : null,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      'name': name,
      'email': email,
      'group': group,
      if (phone != null) 'phone': phone,
      'status': status,
      'created_at': createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    };
  }

  // Copy with method for updating
  Student copyWith({
    String? id,
    String? studentId,
    String? name,
    String? email,
    String? group,
    String? phone,
    String? status,
    DateTime? createdAt,
  }) {
    return Student(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      name: name ?? this.name,
      email: email ?? this.email,
      group: group ?? this.group,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}