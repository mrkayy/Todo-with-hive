part of 'task_bloc.dart';

// @immutable
// abstract class TaskState extends Equatable {
//   ValueListenable<Box<Task>> listenToTasks();
//   addTask();
//   Task updateTask();
//   deleteTask();
// }

class TaskState extends Equatable {
  final List<Task> tasks;

  const TaskState({this.tasks = const <Task>[]});

  @override
  List<Object?> get props => [tasks];

  @override
  addTask() {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  ValueListenable<Box<Task>> listenToTasks() {
    // TODO: implement listenToTasks
    throw UnimplementedError();
  }

  @override
  deleteTask() {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  updateTask() {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
