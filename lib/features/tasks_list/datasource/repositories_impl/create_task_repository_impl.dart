import 'package:either_dart/either.dart';

import 'package:flutter_firebase_list/features/tasks_list/datasource/exceptions/create_task_exception_unknown.dart';
import 'package:flutter_firebase_list/features/tasks_list/datasource/sources/remote/create_task_remote_source.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task_info.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/repositories/create_task_repository.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/create_task.dart';

class CreateTaskRepositoryImpl extends CreateTaskRepository {
  CreateTaskRepositoryImpl(this._remoteSource);

  final CreateTaskRemoteSource _remoteSource;

  @override
  Future<Either<Task, CreateTaskException>> createTask(
      TaskInfo taskInfo) async {
    try {
      return Left(await _remoteSource.createTask(taskInfo));
    } catch (e, stk) {
      return Right(CreateTaskExceptionUnknown(e, stk));
    }
  }
}
