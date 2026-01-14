class Reminder {
  final String id;
  final String title;
  final String message;
  final DateTime time;
  final List<int> repeatDays; // 0-6 代表周日到周六
  final bool isEnabled;
  final DateTime createdAt;

  Reminder({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    this.repeatDays = const [],
    this.isEnabled = true,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Reminder copyWith({
    String? title,
    String? message,
    DateTime? time,
    List<int>? repeatDays,
    bool? isEnabled,
  }) {
    return Reminder(
      id: id,
      title: title ?? this.title,
      message: message ?? this.message,
      time: time ?? this.time,
      repeatDays: repeatDays ?? this.repeatDays,
      isEnabled: isEnabled ?? this.isEnabled,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'message': message,
    'time': time.toIso8601String(),
    'repeatDays': repeatDays,
    'isEnabled': isEnabled,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
    id: json['id'],
    title: json['title'],
    message: json['message'],
    time: DateTime.parse(json['time']),
    repeatDays: List<int>.from(json['repeatDays'] ?? []),
    isEnabled: json['isEnabled'] ?? true,
    createdAt: DateTime.parse(json['createdAt']),
  );
}
