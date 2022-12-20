import 'package:flutter_firebase_list/features/tasks_list/datasource/sources/remote/get_tasks_remote_source.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/services/custom_firestore/custom_firestore.dart';

class GetTasksRemoteSourceFirestore implements GetTasksRemoteSource {
  GetTasksRemoteSourceFirestore([FirestoreService? service])
      : _service = service ?? FirestoreService();

  final FirestoreService _service;

  @override
  Future<List<Task>> getTasks(String userId) async {
    final data = await _service.getTasks(userId);
    return data
        .map((e) => Task(
              id: e.id,
              title: e.taskFieldsDTO.title,
              description: e.taskFieldsDTO.description,
              usersIds: e.taskFieldsDTO.usersIds,
              createdAt: e.taskFieldsDTO.createdAt,
              updatedAt: e.taskFieldsDTO.updatedAt,
            ))
        .toList();
  }
}
