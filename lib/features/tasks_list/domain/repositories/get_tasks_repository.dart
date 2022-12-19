import 'package:either_dart/either.dart';

import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/get_tasks.dart';

abstract class GetTasksRepository {
  Future<Either<List<Task>, GetTasksException>> getTasks(String userId);
}
