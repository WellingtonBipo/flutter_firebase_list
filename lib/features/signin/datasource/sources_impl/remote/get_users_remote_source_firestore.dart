import 'package:flutter_firebase_list/features/signin/datasource/sources/remote/get_users_remote_source.dart';
import 'package:flutter_firebase_list/features/signin/domain/entities/user_id.dart';
import 'package:flutter_firebase_list/services/custom_firestore/custom_firestore.dart';

class GetUsersRemoteSourceFirestore implements GetUsersRemoteSource {
  @override
  Future<List<UserInfo>> getUsers() async {
    return FirestoreService.getUsers();
  }
}
