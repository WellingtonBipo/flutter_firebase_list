import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/task_fields_dto.dart';

class TaskFirestore extends Equatable {
  const TaskFirestore({
    required this.id,
    required this.taskFieldsDTO,
  });

  final String id;
  final TaskFieldsDTO taskFieldsDTO;

  @override
  List<Object?> get props => [id, taskFieldsDTO];
}
