import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/repositories/delete_task_repository.dart';

class DeleteTask {
  DeleteTask(this._repository);

  final DeleteTaskRepository _repository;

  Future<DeleteTaskException?> call(Task task) => _repository.deleteTask(task);
}

class DeleteTaskException {}
