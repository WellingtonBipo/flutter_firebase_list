import 'package:flutter_firebase_list/services/custom_firestore/dtos/task_fields_dto.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/task_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final taskFieldsDTO = TaskFieldsDTO(
    title: 'title',
    description: 'description',
    usersIds: const {'usersId'},
    createdAt: DateTime(2000),
    updatedAt: DateTime(2000),
  );

  final taskFieldsDTOEqual = TaskFieldsDTO(
    title: 'title',
    description: 'description',
    usersIds: const {'usersId'},
    createdAt: DateTime(2000),
    updatedAt: DateTime(2000),
  );

  final taskFieldsDTODiff = TaskFieldsDTO(
    title: 'title2',
    description: 'description2',
    usersIds: const {'usersId2'},
    createdAt: DateTime(2001),
    updatedAt: DateTime(2001),
  );

  final data = TaskFirestore(
    id: 'id',
    taskFieldsDTO: taskFieldsDTO,
  );

  final dataEqual = TaskFirestore(
    id: 'id',
    taskFieldsDTO: taskFieldsDTOEqual,
  );

  final dataDiff = TaskFirestore(
    id: 'id2',
    taskFieldsDTO: taskFieldsDTODiff,
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
