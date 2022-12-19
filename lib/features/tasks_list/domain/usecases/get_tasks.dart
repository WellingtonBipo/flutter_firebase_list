import 'package:either_dart/either.dart';

import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/repositories/get_tasks_repository.dart';

class GetTasks {
  GetTasks(this._repository);

  final GetTasksRepository _repository;

  Future<Either<List<Task>, GetTasksException>> call(String userId) =>
      _repository.getTasks(userId);
}

class GetTasksException {}
