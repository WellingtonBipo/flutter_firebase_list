import 'package:flutter_firebase_list/features/signup/domain/entities/signup_request.dart';

abstract class SignupRemoteSource {
  Future<bool> hasUsersWithEmail(String email);
  Future<String> createUserAndReturnId(SignupRequest data);
}
