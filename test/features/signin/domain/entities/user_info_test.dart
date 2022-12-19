// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_firebase_list/features/signin/domain/entities/user_info.dart';

void main() {
  final data = UserInfo(
      id: 'id',
      name: 'name',
      email: 'email',
      tasks: {'task1', 'task2'},
      createdAt: DateTime(2000));
  final dataEqual = UserInfo(
      id: 'id',
      name: 'name',
      email: 'email',
      tasks: {'task1', 'task2'},
      createdAt: DateTime(2000));
  final dataDiff = UserInfo(
      id: 'id2',
      name: 'name2',
      email: 'email2',
      tasks: {'task3'},
      createdAt: DateTime(2001));
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
