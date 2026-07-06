import 'package:flutter/foundation.dart';

@immutable
class TaskModel {
  final int? id;
  final String text;
  final bool isDone;

  const TaskModel({
    this.id,
    required this.text,
    this.isDone = false,
  });

  /// Creates a copy of this TaskModel with updated properties.
  TaskModel copyWith({
    int? id,
    String? text,
    bool? isDone,
  }) {
    return TaskModel(
      id: id ?? this.id,
      text: text ?? this.text,
      isDone: isDone ?? this.isDone,
    );
  }

  /// Converts the TaskModel into a Map structure for database persistence.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'isDone': isDone ? 1 : 0,
    };
  }

  /// Reconstructs a TaskModel from a database Map.
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int?,
      text: map['text'] as String? ?? '',
      isDone: map['isDone'] == 1,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          isDone == other.isDone;

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ isDone.hashCode;
}
