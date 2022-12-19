import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/update_task.dart';

abstract class UpdateTaskRepository {
  Future<UpdateTaskException?> updateTask(Task task);
}
