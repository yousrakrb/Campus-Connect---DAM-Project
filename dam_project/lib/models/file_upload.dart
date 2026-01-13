// lib/models/file_upload.dart
class FileUpload {
  final String? id;
  final String fileName;
  final String filePath;
  final String fileType; // 'image', 'pdf', 'doc', 'xls'
  final double fileSize;
  final String uploadedBy;
  final DateTime uploadDate;
  final String? description;
  final String? targetGroup; // For which group
  final String? targetCourse; // For which course

  FileUpload({
    this.id,
    required this.fileName,
    required this.filePath,
    required this.fileType,
    required this.fileSize,
    required this.uploadedBy,
    required this.uploadDate,
    this.description,
    this.targetGroup,
    this.targetCourse,
  });

  factory FileUpload.fromJson(Map<String, dynamic> json) {
    return FileUpload(
      id: json['id']?.toString(),
      fileName: json['file_name'] ?? '',
      filePath: json['file_path'] ?? '',
      fileType: json['file_type'] ?? 'pdf',
      fileSize: json['file_size'] != null
          ? double.parse(json['file_size'].toString())
          : 0,
      uploadedBy: json['uploaded_by'] ?? '',
      uploadDate: json['upload_date'] != null
          ? DateTime.parse(json['upload_date'])
          : DateTime.now(),
      description: json['description'],
      targetGroup: json['target_group'],
      targetCourse: json['target_course'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'file_name': fileName,
      'file_path': filePath,
      'file_type': fileType,
      'file_size': fileSize,
      'uploaded_by': uploadedBy,
      'upload_date': uploadDate.toIso8601String(),
      if (description != null) 'description': description,
      if (targetGroup != null) 'target_group': targetGroup,
      if (targetCourse != null) 'target_course': targetCourse,
    };
  }
}