import 'package:flutter_firebase_list/features/signin/datasource/repositories_impl/get_users_repository_impl.dart';
import 'package:flutter_firebase_list/features/signin/datasource/sources_impl/remote/get_users_remote_source_firestore.dart';
import 'package:flutter_firebase_list/features/signup/datasource/repositories_impl/signup_repository_impl.dart';
import 'package:flutter_firebase_list/features/signup/datasource/sources_impl/remote/signup_remote_source_firestore.dart';
import 'package:flutter_firebase_list/features/signup/domain/usecases/signup.dart';
import 'package:provider/provider.dart';

import 'features/signin/domain/usecases/get_users.dart';

abstract class Injectors {
  static List<Provider> get providers => [
        signupProvider,
        getUsersProvider,
      ];

  static Provider<Signup> signupProvider = Provider<Signup>(
      create: (_) =>
          Signup(SignupRepositoryImpl(SignupRemoteSourceFirestore())));

  static Provider<GetUsers> getUsersProvider = Provider<GetUsers>(
      create: (_) =>
          GetUsers(GetUsersRepositoryImpl(GetUsersRemoteSourceFirestore())));
}
