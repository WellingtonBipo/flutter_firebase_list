import 'package:flutter_firebase_list/features/tasks_list/datasource/exceptions/update_task_exception_unknown.dart';
import 'package:flutter_firebase_list/features/tasks_list/datasource/sources/remote/update_task_remote_source.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/repositories/update_task_repository.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/update_task.dart';

class UpdateTaskRepositoryImpl extends UpdateTaskRepository {
  UpdateTaskRepositoryImpl(this._remoteSource);

  final UpdateTaskRemoteSource _remoteSource;

  @override
  Future<UpdateTaskException?> updateTask(Task task) async {
    try {
      await _remoteSource.updateTask(task);
      return null;
    } catch (e, stk) {
      return UpdateTaskExceptionUnknown(e, stk);
    }
  }
}
