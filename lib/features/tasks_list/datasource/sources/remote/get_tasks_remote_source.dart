import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';

abstract class GetTasksRemoteSource {
  Future<List<Task>> getTasks(String userId);
}
