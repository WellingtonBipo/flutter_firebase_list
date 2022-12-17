import 'package:either_dart/either.dart';
import 'package:flutter_firebase_list/features/list/domain/entities/signup_request.dart';
import 'package:flutter_firebase_list/features/list/domain/usecases/signup.dart';

class SignupImpl implements Signup {
  SignupImpl(this._repository);

  final SignupRepository _repository;

  @override
  Future<Either<void, SignupError>> call(SignupRequest request) =>
      _repository.signup(request);
}

abstract class SignupRepository {
  Future<Either<void, SignupError>> signup(SignupRequest request);
}
