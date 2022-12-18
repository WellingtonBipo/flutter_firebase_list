import 'package:cloud_firestore/cloud_firestore.dart';

class UserFieldsDTO {
  static const String nameId = 'nome';
  static const String emailId = 'email';
  static const String createdAtId = 'createdAt';

  UserFieldsDTO({
    required this.name,
    required this.email,
    required this.createdAt,
  });

  final String name;
  final String email;
  final DateTime createdAt;

  Map<String, dynamic> toMap() => {
        nameId: name,
        emailId: email,
        createdAtId: createdAt,
      };

  factory UserFieldsDTO.fromMap(Map map) => UserFieldsDTO(
        name: map[nameId],
        email: map[emailId],
        createdAt: (map[createdAtId] as Timestamp).toDate(),
      );
}
