import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hive_tdo/data/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  //TODO: Inject required usecase
  TaskBloc() : super(const TaskState()) {
    on<AddTask>(_addTask);
    on<UpdateTask>(_updateTask);
    on<DeleteTask>(_deleteTask);
  }

  void _addTask(AddTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(tasks: List.from(state.tasks)..add(event.task)));
  }

  void _updateTask(UpdateTask event, Emitter<TaskState> emit) {}
  void _deleteTask(DeleteTask event, Emitter<TaskState> emit) {}
}
