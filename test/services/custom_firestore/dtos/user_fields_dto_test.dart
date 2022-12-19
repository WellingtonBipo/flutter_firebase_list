// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter_firebase_list/services/custom_firestore/dtos/user_fields_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final data = UserFieldsDTO(
    name: 'name',
    email: 'email',
    tasks: {'task'},
    createdAt: DateTime(2000),
  );

  final dataEqual = UserFieldsDTO(
    name: 'name',
    email: 'email',
    tasks: {'task'},
    createdAt: DateTime(2000),
  );

  final dataDiff = UserFieldsDTO(
    name: 'name2',
    email: 'email2',
    tasks: {'task2'},
    createdAt: DateTime(2001),
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

  test(
    'When map an instances, should be the same',
    () {
      final map = data.toMap();
      final newData = UserFieldsDTO.fromMap(map);
      expect(data, newData);
    },
  );
}
