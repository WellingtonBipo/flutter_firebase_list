import 'package:flutter_firebase_list/features/signup/datasource/sources/remote/signup_remote_source.dart';
import 'package:flutter_firebase_list/features/signup/domain/entities/signup_request.dart';
import 'package:flutter_firebase_list/services/custom_firestore/custom_firestore.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/user_fields_dto.dart';

class SignupRemoteSourceFirestore implements SignupRemoteSource {
  @override
  Future<bool> hasUsersWithEmail(String email) async {
    return FirestoreService.hasUsersWithEmail(email);
  }

  @override
  Future<String> createUserAndReturnId(SignupRequest data) async {
    final dto = UserFieldsDTO(
      name: data.name,
      email: data.email,
      tasks: [],
      createdAt: DateTime.now(),
    );
    return FirestoreService.createUserAndReturnId(dto);
  }
}
