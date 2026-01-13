// lib/models/user.dart
class User {
  final String? id;
  final String name;
  final String email;
  final String password;
  final String role; // 'admin', 'teacher', 'student'
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? lastLogin;
  final bool isActive;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.profileImage,
    this.createdAt,
    this.lastLogin,
    this.isActive = true,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? 'student',
      profileImage: json['profile_image'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      lastLogin: json['last_login'] != null
          ? DateTime.parse(json['last_login'])
          : null,
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      if (profileImage != null) 'profile_image': profileImage,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (lastLogin != null) 'last_login': lastLogin!.toIso8601String(),
      'is_active': isActive,
    };
  }
}