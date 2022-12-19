import 'package:either_dart/either.dart';
import 'package:flutter_firebase_list/features/signin/domain/entities/user_id.dart';

import 'package:flutter_firebase_list/features/signup/domain/entities/signup_request.dart';
import 'package:flutter_firebase_list/features/signup/domain/usecases/signup.dart';

abstract class SignupRepository {
  Future<Either<UserInfo, SignupException>> signup(SignupRequest request);
}
