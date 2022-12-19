import 'package:flutter_firebase_list/features/tasks_list/datasource/sources/remote/delete_task_remote_source.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/services/custom_firestore/custom_firestore.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/task_fields_dto.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/task_firestore.dart';

class DeleteTaskRemoteSourceFirestore implements DeleteTaskRemoteSource {
  @override
  Future<void> deleteTask(Task task) async {
    final data = TaskFirestore(
        id: task.id,
        taskFieldsDTO: TaskFieldsDTO(
          title: task.title,
          description: task.description,
          usersIds: task.usersIds,
          createdAt: task.createdAt,
          updatedAt: task.updatedAt,
        ));
    await FirestoreService.deleteTask(data);
  }
}
