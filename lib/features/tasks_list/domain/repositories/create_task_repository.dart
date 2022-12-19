import 'package:either_dart/either.dart';

import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task_info.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/create_task.dart';

abstract class CreateTaskRepository {
  Future<Either<Task, CreateTaskException>> createTask(TaskInfo taskInfo);
}
