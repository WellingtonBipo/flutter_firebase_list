// ignore_for_file: prefer_const_constructors

import 'package:flutter_firebase_list/features/signin/domain/entities/user_info.dart';
import 'package:flutter_firebase_list/features/signup/datasource/exceptions/signup_unknown_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_firebase_list/features/signup/datasource/exceptions/signup_email_already_exists_excpetion.dart';
import 'package:flutter_firebase_list/features/signup/datasource/sources/remote/signup_remote_source.dart';
import 'package:flutter_firebase_list/features/signup/domain/entities/signup_request.dart';
import 'package:flutter_firebase_list/features/signup/datasource/repositories_impl/signup_repository_impl.dart';

class SignupRemoteSourceMock extends Mock implements SignupRemoteSource {}

class UserInfoMock extends Mock implements UserInfo {}

void main() {
  final source = SignupRemoteSourceMock();
  final repo = SignupRepositoryImpl(source);
  final request = SignupRequest(name: 'name', email: 'email');

  registerFallbackValue(request);

  test(
    'When try signup with email that already exist, return SignupEmailAlreadyExistsExcpetion',
    () async {
      when(() => source.hasUsersWithEmail(any())).thenAnswer((_) async => true);
      final result = await repo.signup(request);
      expect(result.right, isA<SignupEmailAlreadyExistsExcpetion>());
    },
  );

  test(
    'When try signup with email that not exist, return UserInfo',
    () async {
      when(() => source.hasUsersWithEmail(any()))
          .thenAnswer((_) async => false);
      when(() => source.createUser(any()))
          .thenAnswer((_) async => UserInfoMock());

      final result = await repo.signup(request);
      expect(result.left, isA<UserInfo>());
    },
  );

  test(
    'When try signup and an unknown exception is thrown, return SignupUnknownException',
    () async {
      final e = Exception('e');
      when(() => source.hasUsersWithEmail(any())).thenThrow(e);

      final result = await repo.signup(request);
      expect(
          result.right,
          isA<SignupUnknownException>()
              .having((p0) => p0.exception, 'esception', e));
    },
  );
}
