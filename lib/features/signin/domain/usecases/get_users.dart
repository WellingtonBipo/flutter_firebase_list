import 'package:either_dart/either.dart';
import 'package:flutter_firebase_list/features/signin/domain/entities/user_info.dart';
import 'package:flutter_firebase_list/features/signin/domain/repositories/get_users_repository.dart';

class GetUsers {
  GetUsers(this._repository);

  final GetUsersRepository _repository;

  Future<Either<List<UserInfo>, GetUsersException>> call() =>
      _repository.getUsers();
}

class GetUsersException {}
