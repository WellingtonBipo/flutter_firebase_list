// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:either_dart/either.dart';
import 'package:flutter_firebase_list/features/signin/domain/entities/user_info.dart';
import 'package:flutter_firebase_list/features/signup/domain/entities/signup_request.dart';
import 'package:flutter_firebase_list/features/signup/domain/repositories/signup_repository.dart';
import 'package:flutter_firebase_list/features/signup/domain/usecases/signup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SignupRepositoryMock extends Mock implements SignupRepository {}

class SignupExceptionMock extends SignupException {}

void main() {
  final repo = SignupRepositoryMock();
  final signup = Signup(repo);
  final request = SignupRequest(name: 'name', email: 'email');
  final userInfo = UserInfo(
    id: 'id',
    name: 'name',
    email: 'email',
    tasks: {'task'},
    createdAt: DateTime(2000),
  );
  final failure = SignupExceptionMock();

  registerFallbackValue(SignupRequest(name: 'name', email: 'email'));

  test(
    'When call signup and repo return success, return instance of UserInfo',
    () async {
      when(() => repo.signup(any())).thenAnswer((_) async => Left(userInfo));
      final result = await signup(request);
      expect(
          result, isA<Either>().having((p0) => p0.left, 'userInfo', userInfo));
    },
  );

  test(
    'When call signup and repo return failure, '
    'return implementation of SignupException',
    () async {
      when(() => repo.signup(any())).thenAnswer((_) async => Right(failure));
      final result = await signup(request);
      expect(result,
          isA<Either>().having((p0) => p0.right, 'SignupException', failure));
    },
  );
}
