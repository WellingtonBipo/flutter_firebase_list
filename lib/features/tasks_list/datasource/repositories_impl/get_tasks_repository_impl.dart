import 'package:either_dart/either.dart';
import 'package:flutter_firebase_list/features/tasks_list/datasource/exceptions/get_tasks_exception_unknown.dart';
import 'package:flutter_firebase_list/features/tasks_list/datasource/sources/remote/get_tasks_remote_source.dart';

import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/repositories/get_tasks_repository.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/get_tasks.dart';

class GetTasksRepositoryImpl extends GetTasksRepository {
  GetTasksRepositoryImpl(this._remoteSource);

  final GetTasksRemoteSource _remoteSource;

  @override
  Future<Either<List<Task>, GetTasksException>> getTasks(String userId) async {
    try {
      return Left(await _remoteSource.getTasks(userId));
    } catch (e, stk) {
      return Right(GetTasksExceptionUnknown(e, stk));
    }
  }
}
