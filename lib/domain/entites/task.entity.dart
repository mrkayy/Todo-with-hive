import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  TaskEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.createdAtTime,
    required this.createdAtDate,
    required this.isCompleted,
  });
  String id;
  String title;
  String subtitle;
  DateTime createdAtTime;
  DateTime createdAtDate;
  bool isCompleted;

  @override
  List<Object?> get props =>
      [id, title, subtitle, isCompleted, createdAtDate, createdAtTime];
}
