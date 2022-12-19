// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter_firebase_list/services/custom_firestore/dtos/task_fields_dto.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/task_firestore.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/user_info_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

import 'package:flutter_firebase_list/services/custom_firestore/custom_firestore.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/user_fields_dto.dart';

void main() {
  final userDto = UserFieldsDTO(
    name: 'name',
    email: 'email',
    tasks: {},
    createdAt: DateTime(2000),
  );

  taskDto(String userId) => TaskFieldsDTO(
        title: 'title',
        description: 'description',
        usersIds: {userId},
        createdAt: DateTime(2000),
        updatedAt: DateTime(2000),
      );

  setUp(() {
    FirestoreService.instanceForTest = FakeFirebaseFirestore();
  });

  tearDown(() {
    // mockStore.dump();
  });

  test(
    'When create user, completes with right values',
    () async {
      final user = await FirestoreService.createUser(userDto);
      expect(
          user,
          isA<UserInfoFirestore>()
              .having((p0) => p0.id, 'id', isA<String>())
              .having((p0) => p0.userFieldsDTO, 'userFieldsDTO', userDto));
    },
  );

  test(
    'When there is no email used return false',
    () async {
      expect(await FirestoreService.hasUsersWithEmail(userDto.email), isFalse);
    },
  );

  test(
    'When there email used return false',
    () async {
      await FirestoreService.createUser(userDto);
      expect(await FirestoreService.hasUsersWithEmail(userDto.email), isTrue);
    },
  );

  test(
    'When get users, return users created',
    () async {
      final userDto2 = UserFieldsDTO(
        name: 'name2',
        email: 'email2',
        tasks: {},
        createdAt: DateTime(2001),
      );

      final user = await FirestoreService.createUser(userDto);
      final user2 = await FirestoreService.createUser(userDto2);

      final users = await FirestoreService.getUsers();
      expect(users, hasLength(2));
      expect(users[0], user);
      expect(users[1], user2);
    },
  );

  test(
    'When create task, completes with right values',
    () async {
      final user = await FirestoreService.createUser(userDto);
      final task = await FirestoreService.createTask(taskDto(user.id));
      final tasks = await FirestoreService.getTasks(user.id);

      expect(tasks, hasLength(1));
      expect(
        tasks.first,
        isA<TaskFirestore>().having((p0) => p0.id, 'id', task.id).having(
            (p0) => p0.taskFieldsDTO, 'taskFieldsDTO', taskDto(user.id)),
      );
    },
  );

  test(
    'When create task, taskId has linked with user',
    () async {
      final user = await FirestoreService.createUser(userDto);
      final task = await FirestoreService.createTask(taskDto(user.id));
      final users = await FirestoreService.getUsers();
      final userUpdated = users.first;

      expect(userUpdated.userFieldsDTO.tasks, contains(task.id));
    },
  );

  test(
    'When update task, completes with right values',
    () async {
      final user = await FirestoreService.createUser(userDto);
      final task = await FirestoreService.createTask(taskDto(user.id));
      final taskUpdated = TaskFirestore(
          id: task.id,
          taskFieldsDTO: TaskFieldsDTO(
            title: task.taskFieldsDTO.title,
            description: 'description2',
            usersIds: task.taskFieldsDTO.usersIds,
            createdAt: task.taskFieldsDTO.createdAt,
            updatedAt: task.taskFieldsDTO.updatedAt,
          ));
      await FirestoreService.updateTask(taskUpdated);
      final tasks = await FirestoreService.getTasks(user.id);

      expect(tasks, hasLength(1));
      expect(
        tasks.first,
        isA<TaskFirestore>().having((p0) => p0.id, 'id', taskUpdated.id).having(
            (p0) => p0.taskFieldsDTO,
            'taskFieldsDTO',
            taskUpdated.taskFieldsDTO),
      );
    },
  );

  test(
    'When delete task, completes with no such task',
    () async {
      final user = await FirestoreService.createUser(userDto);
      final task = await FirestoreService.createTask(taskDto(user.id));
      await FirestoreService.deleteTask(task);
      final tasks = await FirestoreService.getTasks(user.id);

      expect(tasks, hasLength(0));
      expect(tasks.contains(task), isFalse);
    },
  );

  test(
    'When delete task, completes users not having task id anymore',
    () async {
      final user = await FirestoreService.createUser(userDto);
      final task = await FirestoreService.createTask(taskDto(user.id));
      await FirestoreService.deleteTask(task);
      final users = await FirestoreService.getUsers();

      expect(
          users.any((e) => e.userFieldsDTO.tasks.contains(task.id)), isFalse);
    },
  );
}
