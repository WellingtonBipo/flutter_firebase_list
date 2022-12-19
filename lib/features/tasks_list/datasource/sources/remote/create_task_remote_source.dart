import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task_info.dart';

abstract class CreateTaskRemoteSource {
  Future<Task> createTask(TaskInfo taskInfo);
}
