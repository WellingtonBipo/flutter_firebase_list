import 'package:flutter_firebase_list/services/custom_firestore/dtos/task_fields_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final data = TaskFieldsDTO(
    title: 'title',
    description: 'description',
    usersIds: const {'usersId'},
    createdAt: DateTime(2000),
    updatedAt: DateTime(2000),
  );

  final dataEqual = TaskFieldsDTO(
    title: 'title',
    description: 'description',
    usersIds: const {'usersId'},
    createdAt: DateTime(2000),
    updatedAt: DateTime(2000),
  );

  final dataDiff = TaskFieldsDTO(
    title: 'title2',
    description: 'description2',
    usersIds: const {'usersId2'},
    createdAt: DateTime(2001),
    updatedAt: DateTime(2001),
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
      final newData = TaskFieldsDTO.fromMap(map);
      expect(data, newData);
    },
  );
}
