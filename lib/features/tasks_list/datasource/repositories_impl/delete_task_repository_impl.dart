import 'package:flutter_firebase_list/features/tasks_list/datasource/exceptions/delete_task_exception_unknown.dart';
import 'package:flutter_firebase_list/features/tasks_list/datasource/sources/remote/delete_task_remote_source.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/repositories/delete_task_repository.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/delete_task.dart';

class DeleteTaskRepositoryImpl extends DeleteTaskRepository {
  DeleteTaskRepositoryImpl(this._remoteSource);

  final DeleteTaskRemoteSource _remoteSource;

  @override
  Future<DeleteTaskException?> deleteTask(Task task) async {
    try {
      await _remoteSource.deleteTask(task);
      return null;
    } catch (e, stk) {
      return DeleteTaskExceptionUnknown(e, stk);
    }
  }
}
