import 'package:flutter_firebase_list/features/tasks_list/datasource/sources/remote/update_task_remote_source.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/services/custom_firestore/custom_firestore.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/task_fields_dto.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/task_firestore.dart';

class UpdateTaskRemoteSourceFirestore implements UpdateTaskRemoteSource {
  UpdateTaskRemoteSourceFirestore([FirestoreService? service])
      : _service = service ?? FirestoreService();

  final FirestoreService _service;

  @override
  Future<void> updateTask(Task task) async {
    final data = TaskFirestore(
        id: task.id,
        taskFieldsDTO: TaskFieldsDTO(
          title: task.title,
          description: task.description,
          usersIds: task.usersIds,
          createdAt: task.createdAt,
          updatedAt: task.updatedAt,
        ));
    await _service.updateTask(data);
  }
}
