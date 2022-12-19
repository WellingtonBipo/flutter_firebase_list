import 'package:flutter_firebase_list/features/signin/domain/entities/user_info.dart';

abstract class GetUsersRemoteSource {
  Future<List<UserInfo>> getUsers();
}
