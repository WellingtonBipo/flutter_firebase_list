// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:either_dart/either.dart';
import 'package:flutter_firebase_list/features/signin/domain/entities/user_info.dart';
import 'package:flutter_firebase_list/features/signup/datasource/exceptions/signup_email_already_exists_excpetion.dart';
import 'package:flutter_firebase_list/features/signup/domain/entities/signup_request.dart';
import 'package:flutter_firebase_list/features/signup/domain/usecases/signup.dart';
import 'package:flutter_firebase_list/features/signup/presenter/signup_screen_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SignupMock extends Mock implements Signup {}

class SignupExceptionMock extends Mock implements SignupException {}

class CallBackCount {
  int count = 0;
  dynamic v;

  call([dynamic v]) {
    count++;
    this.v = v;
  }
}

void main() {
  final signupMock = SignupMock();
  final controller = SignupScreenController(signupMock);

  late CallBackCount onNameEmpty;
  late CallBackCount onEmailEmpty;
  late CallBackCount onSuccess;
  late CallBackCount onEmailAlreadyExist;
  late CallBackCount onUnkownError;

  setUp(() {
    onNameEmpty = CallBackCount();
    onEmailEmpty = CallBackCount();
    onSuccess = CallBackCount();
    onEmailAlreadyExist = CallBackCount();
    onUnkownError = CallBackCount();
  });

  registerFallbackValue(SignupRequest(name: 'name', email: 'email'));

  test(
    'When signup called with empty name should call onNameEmpty',
    () async {
      final result = await controller.signup(
        name: '',
        email: 'email',
        onNameEmpty: onNameEmpty,
        onEmailEmpty: onEmailEmpty,
        onSuccess: onSuccess,
        onEmailAlreadyExist: onEmailAlreadyExist,
        onUnkownError: onUnkownError,
      );

      result();

      expect(onEmailEmpty.count, 0);
      expect(onSuccess.count, 0);
      expect(onEmailAlreadyExist.count, 0);
      expect(onUnkownError.count, 0);
      expect(onNameEmpty.count, 1);
    },
  );

  test(
    'When signup called with empty email should call onEmailEmpty',
    () async {
      final result = await controller.signup(
        name: 'name',
        email: '',
        onNameEmpty: onNameEmpty,
        onEmailEmpty: onEmailEmpty,
        onSuccess: onSuccess,
        onEmailAlreadyExist: onEmailAlreadyExist,
        onUnkownError: onUnkownError,
      );

      result();

      expect(onNameEmpty.count, 0);
      expect(onSuccess.count, 0);
      expect(onEmailAlreadyExist.count, 0);
      expect(onUnkownError.count, 0);
      expect(onEmailEmpty.count, 1);
    },
  );

  test(
    'When signup called with right values, should call onSuccess',
    () async {
      final userInfo = UserInfo(
        id: 'id',
        name: 'name',
        email: 'email',
        tasks: {'task'},
        createdAt: DateTime(2000),
      );

      when(() => signupMock.call(any()))
          .thenAnswer((_) async => Left(userInfo));

      final result = await controller.signup(
        name: 'name',
        email: 'email',
        onNameEmpty: onNameEmpty,
        onEmailEmpty: onEmailEmpty,
        onSuccess: onSuccess,
        onEmailAlreadyExist: onEmailAlreadyExist,
        onUnkownError: onUnkownError,
      );

      result();

      expect(onNameEmpty.count, 0);
      expect(onEmailEmpty.count, 0);
      expect(onEmailAlreadyExist.count, 0);
      expect(onUnkownError.count, 0);
      expect(onSuccess.count, 1);
      expect(onSuccess.v, userInfo);
    },
  );

  test(
    'When signup called with email already exists, should call onEmailAlreadyExist',
    () async {
      when(() => signupMock.call(any()))
          .thenAnswer((_) async => Right(SignupEmailAlreadyExistsExcpetion()));

      final result = await controller.signup(
        name: 'name',
        email: 'email',
        onNameEmpty: onNameEmpty,
        onEmailEmpty: onEmailEmpty,
        onSuccess: onSuccess,
        onEmailAlreadyExist: onEmailAlreadyExist,
        onUnkownError: onUnkownError,
      );

      result();

      expect(onNameEmpty.count, 0);
      expect(onEmailEmpty.count, 0);
      expect(onSuccess.count, 0);
      expect(onUnkownError.count, 0);
      expect(onEmailAlreadyExist.count, 1);
    },
  );

  test(
    'When signup called and throw unknown exception, should call onUnkownError',
    () async {
      final e = SignupExceptionMock();
      when(() => signupMock.call(any())).thenAnswer((_) async => Right(e));

      final result = await controller.signup(
        name: 'name',
        email: 'email',
        onNameEmpty: onNameEmpty,
        onEmailEmpty: onEmailEmpty,
        onSuccess: onSuccess,
        onEmailAlreadyExist: onEmailAlreadyExist,
        onUnkownError: onUnkownError,
      );

      result();

      expect(onNameEmpty.count, 0);
      expect(onEmailEmpty.count, 0);
      expect(onSuccess.count, 0);
      expect(onEmailAlreadyExist.count, 0);
      expect(onUnkownError.count, 1);
      expect(onUnkownError.v, e);
    },
  );
}
