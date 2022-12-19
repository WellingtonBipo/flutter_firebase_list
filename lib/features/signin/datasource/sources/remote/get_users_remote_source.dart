import 'package:flutter_firebase_list/features/signin/domain/entities/user_id.dart';

abstract class GetUsersRemoteSource {
  Future<List<UserInfo>> getUsers();
}
