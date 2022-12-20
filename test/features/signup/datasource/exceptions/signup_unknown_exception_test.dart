import 'package:flutter_firebase_list/features/signup/datasource/exceptions/signup_unknown_exception.dart';
import 'package:flutter_firebase_list/features/signup/domain/usecases/signup.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final exception = Exception('e');
  final stackTrace = StackTrace.current;
  final signupException = SignupUnknownException(exception, stackTrace);

  test(
    'signup unknown exception ...',
    () async {
      expect(signupException, isA<SignupException>());
      expect(
          signupException,
          isA<SignupUnknownException>()
              .having((p0) => p0.exception, 'exception', exception)
              .having((p0) => p0.stackTrace, 'stackTrace', stackTrace));
    },
  );
}
