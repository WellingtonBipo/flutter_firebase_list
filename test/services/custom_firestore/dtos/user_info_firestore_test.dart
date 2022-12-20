// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter_firebase_list/services/custom_firestore/dtos/user_fields_dto.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/user_info_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final userFieldsDTO = UserFieldsDTO(
    name: 'name',
    email: 'email',
    tasks: {'task'},
    createdAt: DateTime(2000),
  );

  final userFieldsDTOEqual = UserFieldsDTO(
    name: 'name',
    email: 'email',
    tasks: {'task'},
    createdAt: DateTime(2000),
  );

  final userFieldsDTODiff = UserFieldsDTO(
    name: 'name2',
    email: 'email2',
    tasks: {'task2'},
    createdAt: DateTime(2001),
  );

  final data = UserInfoFirestore(
    id: 'id',
    userFieldsDTO: userFieldsDTO,
  );

  final dataEqual = UserInfoFirestore(
    id: 'id',
    userFieldsDTO: userFieldsDTOEqual,
  );

  final dataDiff = UserInfoFirestore(
    id: 'id2',
    userFieldsDTO: userFieldsDTODiff,
  );

  test(
    'When compare two equal instances, return true',
    () {
      expect(data, dataEqual);
    },
  );

  test(
    'When compare two different instances, return false',
    () {
      expect(data, isNot(dataDiff));
    },
  );
}
