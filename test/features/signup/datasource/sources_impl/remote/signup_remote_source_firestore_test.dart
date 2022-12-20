// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter_firebase_list/features/signin/domain/entities/user_info.dart';
import 'package:flutter_firebase_list/features/signup/datasource/sources_impl/remote/signup_remote_source_firestore.dart';
import 'package:flutter_firebase_list/features/signup/domain/entities/signup_request.dart';
import 'package:flutter_firebase_list/services/custom_firestore/custom_firestore.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/user_fields_dto.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/user_info_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FirestoreServiceMock extends Mock implements FirestoreService {}

class UserFieldsDTOMock extends Mock implements UserFieldsDTO {}

void main() {
  final service = FirestoreServiceMock();
  final source = SignupRemoteSourceFirestore(service);
  final userFirestore = UserInfoFirestore(
      id: 'id',
      userFieldsDTO: UserFieldsDTO(
        name: 'name',
        email: 'email',
        tasks: {'task'},
        createdAt: DateTime(2000),
      ));
  final request = SignupRequest(name: 'name', email: 'email');

  registerFallbackValue(UserFieldsDTOMock());

  test(
    'When call hasUsersWithEmail return same return',
    () async {
      when(() => service.hasUsersWithEmail(any()))
          .thenAnswer((_) async => true);
      final result = await source.hasUsersWithEmail('email');
      expect(result, isTrue);
    },
  );

  test(
    'When call createUser return same return',
    () async {
      when(() => service.createUser(any()))
          .thenAnswer((_) async => userFirestore);
      final result = await source.createUser(request);
      expect(
          result,
          isA<UserInfo>()
              .having((p0) => p0.id, 'userId', userFirestore.id)
              .having((p0) => p0.name, 'name', userFirestore.userFieldsDTO.name)
              .having(
                  (p0) => p0.email, 'email', userFirestore.userFieldsDTO.email)
              .having(
                  (p0) => p0.tasks, 'tasks', userFirestore.userFieldsDTO.tasks)
              .having((p0) => p0.createdAt, 'createdAt',
                  userFirestore.userFieldsDTO.createdAt));
    },
  );
}
