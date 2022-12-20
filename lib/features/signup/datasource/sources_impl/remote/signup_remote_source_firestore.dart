import 'package:flutter_firebase_list/features/signin/domain/entities/user_info.dart';
import 'package:flutter_firebase_list/features/signup/datasource/sources/remote/signup_remote_source.dart';
import 'package:flutter_firebase_list/features/signup/domain/entities/signup_request.dart';
import 'package:flutter_firebase_list/services/custom_firestore/custom_firestore.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/user_fields_dto.dart';

class SignupRemoteSourceFirestore implements SignupRemoteSource {
  SignupRemoteSourceFirestore([FirestoreService? service])
      : service = service ?? FirestoreService();

  final FirestoreService service;

  @override
  Future<bool> hasUsersWithEmail(String email) async {
    return service.hasUsersWithEmail(email);
  }

  @override
  Future<UserInfo> createUser(SignupRequest data) async {
    final dto = UserFieldsDTO(
      name: data.name,
      email: data.email,
      tasks: const {},
      createdAt: DateTime.now(),
    );
    final userInfo = await service.createUser(dto);
    return UserInfo(
      id: userInfo.id,
      name: userInfo.userFieldsDTO.name,
      email: userInfo.userFieldsDTO.email,
      tasks: userInfo.userFieldsDTO.tasks,
      createdAt: userInfo.userFieldsDTO.createdAt,
    );
  }
}
