import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Task {
  Task({
    required this.task,
    required this.isCompleted,
    required this.startDateTime,
    required this.endDateTime,
    String? id,
  }) : id = id ?? uuid.v4(); // if id is not passed, generate a new one

  final String task;
  final bool isCompleted;
  final String id; // id use for each task
  final DateTime? startDateTime;
  final DateTime? endDateTime;

  Task copyWith({
    String? task,
    bool? isCompleted,
    DateTime? startDateTime,
    DateTime? endDateTime,
    String? id, //id is optional in copyWith
    
  }) {
    return Task(
      task: task ?? this.task,
      isCompleted: isCompleted ?? this.isCompleted,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      id: id ?? this.id, // if id is not passed, use the current id
    );
  }

  static String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // JSON serialization
  Map<String, dynamic> toJson() => {
        'id': id, // add id to JSON
        'task': task,
        'isCompleted': isCompleted,
        'startDateTime': startDateTime?.toIso8601String(),
        'endDateTime': endDateTime?.toIso8601String(),
      };

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'], // отримуємо id з JSON
      task: json['task'],
      isCompleted: json['isCompleted'],
      startDateTime:
          json['startDateTime'] != null ? DateTime.parse(json['startDateTime']) : null,
      endDateTime:
          json['endDateTime'] != null ? DateTime.parse(json['endDateTime']) : null,
    );
  }
}
