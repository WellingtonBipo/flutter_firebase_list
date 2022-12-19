import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserFieldsDTO extends Equatable {
  static const String nameId = 'name';
  static const String emailId = 'email';
  static const String tasksId = 'tasks';
  static const String createdAtId = 'createdAt';

  const UserFieldsDTO({
    required this.name,
    required this.email,
    required this.tasks,
    required this.createdAt,
  });

  final String name;
  final String email;
  final Set<String> tasks;
  final DateTime createdAt;

  Map<String, dynamic> toMap() => {
        nameId: name,
        emailId: email,
        tasksId: tasks.toList(),
        createdAtId: Timestamp.fromDate(createdAt),
      };

  factory UserFieldsDTO.fromMap(Map map) => UserFieldsDTO(
        name: map[nameId],
        email: map[emailId],
        tasks: map[tasksId].cast<String>().toSet(),
        createdAt: (map[createdAtId] as Timestamp).toDate(),
      );

  @override
  List<Object?> get props => [name, email, tasks, createdAt];
}
