import 'package:flutter_firebase_list/features/signup/datasource/repositories_impl/signup_repository_impl.dart';
import 'package:flutter_firebase_list/features/signup/datasource/sources_impl/remote/signup_remote_source_firestore.dart';
import 'package:flutter_firebase_list/features/signup/domain/usecases/signup.dart';
import 'package:provider/provider.dart';

abstract class Injectors {
  static List<Provider> get providers => [
        signinProvider,
      ];

  static Provider<Signup> signinProvider = Provider<Signup>(
      create: (_) =>
          Signup(SignupRepositoryImpl(SignupRemoteSourceFirestore())));
}
