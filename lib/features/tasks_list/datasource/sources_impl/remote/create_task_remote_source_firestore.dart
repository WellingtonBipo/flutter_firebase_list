import 'package:flutter_firebase_list/features/tasks_list/datasource/sources/remote/create_task_remote_source.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task_info.dart';
import 'package:flutter_firebase_list/services/custom_firestore/custom_firestore.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/task_fields_dto.dart';

class CreateTaskRemoteSourceFirestore implements CreateTaskRemoteSource {
  CreateTaskRemoteSourceFirestore([FirestoreService? service])
      : _service = service ?? FirestoreService();

  final FirestoreService _service;
  @override
  Future<Task> createTask(TaskInfo taskInfo) async {
    final taskDTO = TaskFieldsDTO(
      title: taskInfo.title,
      description: taskInfo.description,
      usersIds: {taskInfo.userId},
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final task = await _service.createTask(taskDTO);
    return Task(
      id: task.id,
      title: taskDTO.title,
      description: taskDTO.description,
      usersIds: taskDTO.usersIds,
      createdAt: taskDTO.createdAt,
      updatedAt: taskDTO.updatedAt,
    );
  }
}
