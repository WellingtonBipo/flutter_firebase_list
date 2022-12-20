import 'package:flutter_firebase_list/features/signin/datasource/sources/remote/get_users_remote_source.dart';
import 'package:flutter_firebase_list/features/signin/domain/entities/user_info.dart';
import 'package:flutter_firebase_list/services/custom_firestore/custom_firestore.dart';

class GetUsersRemoteSourceFirestore implements GetUsersRemoteSource {
  GetUsersRemoteSourceFirestore([FirestoreService? service])
      : _service = service ?? FirestoreService();

  final FirestoreService _service;

  @override
  Future<List<UserInfo>> getUsers() async {
    final data = await _service.getUsers();
    return data
        .map((e) => UserInfo(
              id: e.id,
              name: e.userFieldsDTO.name,
              email: e.userFieldsDTO.email,
              tasks: e.userFieldsDTO.tasks,
              createdAt: e.userFieldsDTO.createdAt,
            ))
        .toList();
  }
}
