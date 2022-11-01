import 'package:flutter/foundation.dart';
import 'package:flutter_hive_tdo/data/models/task.dart';
import 'package:flutter_hive_tdo/domain/repo_interface/data_store.interface.dart';
import 'package:hive_flutter/hive_flutter.dart';

///
// import '../models/task.dart';

class HiveDataStore implements HiveDataStoreInterface {
  static const boxName = "tasksBox";
  final Box<Task> box = Hive.box<Task>(boxName);

  /// Add new Task
  @override
  Future<void> addTask({required Task task}) async {
    await box.put(task.id, task);
  }

  /// Show task
  @override
  Future<Task?> getTask({required String id}) async {
    return box.get(id);
  }

  /// Update task
  @override
  Future<void> updateTask({required Task task}) async {
    await task.save();
  }

  /// Delete task
  @override
  Future<void> deleteTask({required Task task}) async {
    await task.delete();
  }

  @override
  ValueListenable<Box<Task>> listenToTask() {
    return box.listenable();
  }
}
