import 'package:either_dart/either.dart';

import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task_info.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/repositories/create_task_repository.dart';

class CreateTask {
  CreateTask(this._repository);

  final CreateTaskRepository _repository;

  Future<Either<Task, CreateTaskException>> call(TaskInfo taskInfo) =>
      _repository.createTask(taskInfo);
}

class CreateTaskException {}
