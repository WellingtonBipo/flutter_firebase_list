import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/delete_task.dart';

abstract class DeleteTaskRepository {
  Future<DeleteTaskException?> deleteTask(Task task);
}
