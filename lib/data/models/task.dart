import 'package:flutter_hive_tdo/domain/entites/task.entity.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends TaskEntity with HiveObjectMixin {
  Task(
      {required this.hId,
      required this.hTitle,
      required this.hSubtitle,
      required this.hCreatedAtTime,
      required this.hCreatedAtDate,
      required this.hIsCompleted})
      : super(
            id: hId,
            title: hTitle,
            subtitle: hSubtitle,
            createdAtTime: hCreatedAtTime,
            createdAtDate: hCreatedAtDate,
            isCompleted: hIsCompleted);

  /// ID
  @HiveField(0)
  final String hId;

  /// TITLE
  @HiveField(1)
  final String hTitle;

  /// SUBTITLE
  @HiveField(2)
  final String hSubtitle;

  /// CREATED AT TIME
  @HiveField(3)
  final DateTime hCreatedAtTime;

  /// CREATED AT DATE
  @HiveField(4)
  final DateTime hCreatedAtDate;

  /// IS COMPLETED
  @HiveField(5)
  final bool hIsCompleted;

  /// create new Task
  factory Task.create({
    required String? title,
    required String? subtitle,
    DateTime? createdAtTime,
    DateTime? createdAtDate,
  }) =>
      Task(
        hId: const Uuid().v1(),
        hTitle: title ?? "",
        hSubtitle: subtitle ?? "",
        hCreatedAtTime: createdAtTime ?? DateTime.now(),
        hIsCompleted: false,
        hCreatedAtDate: createdAtDate ?? DateTime.now(),
      );
}
