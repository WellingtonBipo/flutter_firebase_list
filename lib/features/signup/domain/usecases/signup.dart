import 'package:either_dart/either.dart';

import 'package:flutter_firebase_list/features/signup/domain/entities/signup_request.dart';
import 'package:flutter_firebase_list/features/signup/domain/entities/user_id.dart';

abstract class Signup {
  Future<Either<UserId, SignupException>> call(SignupRequest request);
}

class SignupException {}
