import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';

abstract class UpdateTaskRemoteSource {
  Future<void> updateTask(Task task);
}
