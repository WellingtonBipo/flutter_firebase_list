import 'package:either_dart/either.dart';

import 'package:flutter_firebase_list/features/signup/domain/entities/signup_request.dart';
import 'package:flutter_firebase_list/features/signup/domain/entities/user_id.dart';
import 'package:flutter_firebase_list/features/signup/domain/repositories/signup_repository.dart';

class Signup {
  Signup(this._repository);

  final SignupRepository _repository;

  Future<Either<UserId, SignupException>> call(SignupRequest request) =>
      _repository.signup(request);
}

class SignupException {}
