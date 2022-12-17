import 'package:either_dart/either.dart';
import 'package:flutter_firebase_list/features/list/domain/entities/signup_request.dart';

abstract class Signup {
  Future<Either<void, SignupError>> call(SignupRequest request);
}

class SignupError {}
