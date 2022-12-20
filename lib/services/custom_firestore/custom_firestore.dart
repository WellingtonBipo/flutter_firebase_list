import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_firebase_list/services/custom_firestore/dtos/task_fields_dto.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/task_firestore.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/user_fields_dto.dart';
import 'package:flutter_firebase_list/services/custom_firestore/dtos/user_info_firestore.dart';

class FirestoreService {
  FirestoreService([FirebaseFirestore? store])
      : _store = store ?? FirebaseFirestore.instance;
  final FirebaseFirestore _store;

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _store.collection('users');

  CollectionReference<Map<String, dynamic>> get _tasksCollection =>
      _store.collection('tasks');

  Future<UserInfoFirestore> createUser(UserFieldsDTO dto) async {
    final result = await _usersCollection.add(dto.toMap());
    return UserInfoFirestore(id: result.id, userFieldsDTO: dto);
  }

  Future<bool> hasUsersWithEmail(String email) async {
    final usersWithSameEmail = await _usersCollection
        .where(UserFieldsDTO.emailId, isEqualTo: email.trim())
        .get();
    return usersWithSameEmail.docs.isNotEmpty;
  }

  Future<List<UserInfoFirestore>> getUsers() async {
    final users = <UserInfoFirestore>[];
    final result = await _usersCollection.get();
    for (var doc in result.docs) {
      final userFields = UserFieldsDTO.fromMap(doc.data());
      users.add(UserInfoFirestore(id: doc.id, userFieldsDTO: userFields));
    }
    return users;
  }

  Future<TaskFirestore> createTask(TaskFieldsDTO task) async {
    final taskCreated = await _tasksCollection.add(task.toMap());
    final creatorUser = _usersCollection.doc(task.usersIds.first);
    final creatorUserInfo = await creatorUser.get();
    final userTasks = creatorUserInfo.get(UserFieldsDTO.tasksId) as List;
    userTasks.add(taskCreated.id);
    await creatorUser.update({UserFieldsDTO.tasksId: userTasks});
    return TaskFirestore(id: taskCreated.id, taskFieldsDTO: task);
  }

  Future<List<TaskFirestore>> getTasks(String userId) async {
    final userTasks = UserFieldsDTO.fromMap(
            (await _usersCollection.doc(userId).get()).data()!)
        .tasks;
    final tasks = <TaskFirestore>[];
    for (var task in userTasks) {
      final doc = _tasksCollection.doc(task);
      final userFields = TaskFieldsDTO.fromMap((await doc.get()).data()!);
      tasks.add(TaskFirestore(id: doc.id, taskFieldsDTO: userFields));
    }
    return tasks;
  }

  Future<void> updateTask(TaskFirestore task) async {
    await _tasksCollection.doc(task.id).update(task.taskFieldsDTO.toMap());
  }

  Future<void> deleteTask(TaskFirestore task) async {
    await _tasksCollection.doc(task.id).delete();
    for (var userId in task.taskFieldsDTO.usersIds) {
      final user = _usersCollection.doc(userId);
      final userInfo = await user.get();
      final userTasks = userInfo.get(UserFieldsDTO.tasksId) as List;
      userTasks.remove(task.id);
      await user.update({UserFieldsDTO.tasksId: userTasks});
    }
  }
}
