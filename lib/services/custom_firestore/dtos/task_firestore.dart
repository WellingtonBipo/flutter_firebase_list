import 'package:flutter_firebase_list/services/custom_firestore/dtos/task_fields_dto.dart';

class TaskFirestore {
  TaskFirestore({
    required this.id,
    required this.taskFieldsDTO,
  });

  final String id;
  final TaskFieldsDTO taskFieldsDTO;
}
