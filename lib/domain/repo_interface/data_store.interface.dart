import 'package:flutter/foundation.dart';
import 'package:flutter_hive_tdo/data/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveDataStoreInterface {
  Future<void> addTask({required Task task});
  Future<Task?> getTask({required String id});
  Future<void> updateTask({required Task task});
  Future<void> deleteTask({required Task task});
  ValueListenable<Box<Task>> listenToTask();
}
