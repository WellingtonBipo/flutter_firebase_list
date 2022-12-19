import 'package:cloud_firestore/cloud_firestore.dart';

class UserFieldsDTO {
  static const String nameId = 'name';
  static const String emailId = 'email';
  static const String tasksId = 'tasks';
  static const String createdAtId = 'createdAt';

  UserFieldsDTO({
    required this.name,
    required this.email,
    required this.tasks,
    required this.createdAt,
  });

  final String name;
  final String email;
  final List<String> tasks;
  final DateTime createdAt;

  Map<String, dynamic> toMap() => {
        nameId: name,
        emailId: email,
        tasksId: tasks,
        createdAtId: createdAt,
      };

  factory UserFieldsDTO.fromMap(Map map) => UserFieldsDTO(
        name: map[nameId],
        email: map[emailId],
        tasks: map[tasksId].cast<String>(),
        createdAt: (map[createdAtId] as Timestamp).toDate(),
      );
}
