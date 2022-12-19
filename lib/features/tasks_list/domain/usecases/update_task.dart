import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/repositories/update_task_repository.dart';

class UpdateTask {
  UpdateTask(this._repository);

  final UpdateTaskRepository _repository;

  Future<UpdateTaskException?> call(Task task) => _repository.updateTask(task);
}

class UpdateTaskException {}
