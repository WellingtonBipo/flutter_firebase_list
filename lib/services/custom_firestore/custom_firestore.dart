import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_list/features/signin/domain/entities/user_id.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/user_fields_dto.dart';

class FirestoreService {
  static const String _usersCollectionId = 'users';

  static CollectionReference<Map<String, dynamic>> get _users =>
      FirebaseFirestore.instance.collection(_usersCollectionId);

  static Future<bool> hasUsersWithEmail(String email) async {
    final usersWithSameEmail = await _users
        .where(UserFieldsDTO.emailId, isEqualTo: email.trim())
        .get();
    return usersWithSameEmail.docs.isNotEmpty;
  }

  static Future<String> createUserAndReturnId(UserFieldsDTO dto) async {
    final result = await _users.add(dto.toMap());
    return result.id;
  }

  static Future<List<UserInfo>> getUsers() async {
    final users = <UserInfo>[];
    final result =
        await FirebaseFirestore.instance.collection(_usersCollectionId).get();
    for (var doc in result.docs) {
      final userFields = UserFieldsDTO.fromMap(doc.data());
      users.add(UserInfo(
        id: doc.id,
        name: userFields.name,
        email: userFields.email,
        tasks: userFields.tasks,
        createdAt: userFields.createdAt,
      ));
    }
    return users;
  }
}
