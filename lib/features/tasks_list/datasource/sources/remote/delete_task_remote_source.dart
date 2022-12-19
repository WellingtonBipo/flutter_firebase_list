import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';

abstract class DeleteTaskRemoteSource {
  Future<void> deleteTask(Task task);
}
