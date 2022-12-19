import 'package:flutter_firebase_list/features/signin/domain/entities/user_id.dart';
import 'package:flutter_firebase_list/features/signup/domain/entities/signup_request.dart';

abstract class SignupRemoteSource {
  Future<bool> hasUsersWithEmail(String email);
  Future<UserInfo> createUser(SignupRequest data);
}
