import 'package:flutter_firebase_list/features/signin/datasource/repositories_impl/get_users_repository_impl.dart';
import 'package:flutter_firebase_list/features/signin/datasource/sources_impl/remote/get_users_remote_source_firestore.dart';
import 'package:flutter_firebase_list/features/signup/datasource/repositories_impl/signup_repository_impl.dart';
import 'package:flutter_firebase_list/features/signup/datasource/sources_impl/remote/signup_remote_source_firestore.dart';
import 'package:flutter_firebase_list/features/signup/domain/usecases/signup.dart';
import 'package:flutter_firebase_list/features/tasks_list/datasource/repositories_impl/create_task_repository_impl.dart';
import 'package:flutter_firebase_list/features/tasks_list/datasource/repositories_impl/delete_task_repository_impl.dart';
import 'package:flutter_firebase_list/features/tasks_list/datasource/repositories_impl/get_tasks_repository_impl.dart';
import 'package:flutter_firebase_list/features/tasks_list/datasource/repositories_impl/update_tasks_repository_implz.dart';
import 'package:flutter_firebase_list/features/tasks_list/datasource/sources_impl/remote/create_task_remote_source_firestore.dart';
import 'package:flutter_firebase_list/features/tasks_list/datasource/sources_impl/remote/delete_task_remote_source_firestore.dart';
import 'package:flutter_firebase_list/features/tasks_list/datasource/sources_impl/remote/get_tasks_remote_source_firestore.dart';
import 'package:flutter_firebase_list/features/tasks_list/datasource/sources_impl/remote/update_task_remote_source_firestore.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/create_task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/delete_task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/get_tasks.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/update_task.dart';
import 'package:provider/provider.dart';

import 'features/signin/domain/usecases/get_users.dart';

abstract class Injectors {
  static List<Provider> get providers => [
        signupProvider,
        getUsersProvider,
        getTasksProvider,
        createTaskProvider,
        updateTaskProvider,
        deleteTaskProvider,
      ];

  static Provider<Signup> signupProvider = Provider<Signup>(
      create: (_) =>
          Signup(SignupRepositoryImpl(SignupRemoteSourceFirestore())));

  static Provider<GetUsers> getUsersProvider = Provider<GetUsers>(
      create: (_) =>
          GetUsers(GetUsersRepositoryImpl(GetUsersRemoteSourceFirestore())));

  static Provider<GetTasks> getTasksProvider = Provider<GetTasks>(
      create: (_) =>
          GetTasks(GetTasksRepositoryImpl(GetTasksRemoteSourceFirestore())));

  static Provider<CreateTask> createTaskProvider = Provider<CreateTask>(
      create: (_) => CreateTask(
          CreateTaskRepositoryImpl(CreateTaskRemoteSourceFirestore())));

  static Provider<UpdateTask> updateTaskProvider = Provider<UpdateTask>(
      create: (_) => UpdateTask(
          UpdateTaskRepositoryImpl(UpdateTaskRemoteSourceFirestore())));

  static Provider<DeleteTask> deleteTaskProvider = Provider<DeleteTask>(
      create: (_) => DeleteTask(
          DeleteTaskRepositoryImpl(DeleteTaskRemoteSourceFirestore())));
}
