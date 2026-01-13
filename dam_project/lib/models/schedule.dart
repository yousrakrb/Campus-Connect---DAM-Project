// lib/models/schedule.dart - UPDATED
class Schedule {
  final String? id;
  final String teacherId;
  final String className;
  final String subject;
  final String room;
  final DateTime startTime;
  final DateTime endTime;
  final List<int> daysOfWeek; // 1=Monday, 7=Sunday
  final String scheduleType; // 'lecture', 'lab', 'tutorial'
  final bool isActive;

  Schedule({
    this.id,
    required this.teacherId,
    required this.className,
    required this.subject,
    required this.room,
    required this.startTime,
    required this.endTime,
    required this.daysOfWeek,
    required this.scheduleType,
    this.isActive = true,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id']?.toString(),
      teacherId: json['teacher_id'] ?? '',
      className: json['class_name'] ?? '',
      subject: json['subject'] ?? '',
      room: json['room'] ?? '',
      startTime: DateTime.parse(json['start_time'] ?? DateTime.now().toIso8601String()),
      endTime: DateTime.parse(json['end_time'] ?? DateTime.now().toIso8601String()),
      daysOfWeek: List<int>.from(json['days_of_week'] ?? []),
      scheduleType: json['schedule_type'] ?? 'lecture',
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'teacher_id': teacherId,
      'class_name': className,
      'subject': subject,
      'room': room,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'days_of_week': daysOfWeek,
      'schedule_type': scheduleType,
      'is_active': isActive,
    };
  }

  // Helper methods for teacher dashboard
  String get timeRange {
    return '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')} - '
           '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
  }

  bool isToday() {
    final today = DateTime.now().weekday;
    return daysOfWeek.contains(today);
  }

  String get dayName {
    if (daysOfWeek.isEmpty) return '';
    final day = daysOfWeek.first;
    switch (day) {
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