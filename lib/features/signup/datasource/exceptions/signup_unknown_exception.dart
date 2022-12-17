import 'package:flutter_firebase_list/features/signup/domain/usecases/signup.dart';

class SignupUnknownException extends SignupException {
  SignupUnknownException(this.exception, this.stackTrace);

  final Object exception;
  final StackTrace stackTrace;
}
