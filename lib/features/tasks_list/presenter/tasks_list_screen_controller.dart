import 'package:flutter/material.dart';
import 'package:flutter_firebase_list/features/signin/domain/entities/user_info.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task_info.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/create_task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/delete_task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/get_tasks.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/update_task.dart';

class TasksListScreenController {
  TasksListScreenController(
    this.userInfo,
    this._getTasks,
    this._createTask,
    this._updateTask,
    this._deleteTask,
  );

  final UserInfo userInfo;
  final GetTasks _getTasks;
  final CreateTask _createTask;
  final UpdateTask _updateTask;
  final DeleteTask _deleteTask;
  final tasks = ValueNotifier<List<Task>?>(null);

  Future<Object?> getTasks() async {
    final result = await _getTasks(userInfo.id);
    return result.fold<Object?>(
      (left) {
        tasks.value = left..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        return null;
      },
      (right) {
        tasks.value = [];
        return right;
      },
    );
  }

  Future<Object?> createTask(TaskInfo task) async {
    final result = await _createTask(task);
    return result.fold<Object?>(
      (left) {
        final newTasks = [...tasks.value!];
        newTasks.insert(0, left);
        tasks.value = newTasks;
        return null;
      },
      (right) => right,
    );
  }

  Future<Object?> updateTask(Task task) async {
    final result = await _updateTask(task);
    if (result != null) return result;
    final taskIdx = tasks.value!.indexWhere((e) => e.id == task.id);
    final newTasks = [...tasks.value!];
    newTasks.removeAt(taskIdx);
    newTasks.insert(0, task);
    tasks.value = newTasks;
    return null;
  }

  Future<Object?> deleteTask(Task task) async {
    final result = await _deleteTask(task);
    if (result != null) return result;
    final newTasks = [...tasks.value!];
    newTasks.removeWhere((e) => e.id == task.id);
    tasks.value = newTasks;
    return null;
  }
}
