import 'package:either_dart/either.dart';
import 'package:flutter_firebase_list/features/signin/datasource/exceptions/get_users_exception_unknown.dart';

import 'package:flutter_firebase_list/features/signin/datasource/sources/remote/get_users_remote_source.dart';
import 'package:flutter_firebase_list/features/signin/domain/entities/user_id.dart';
import 'package:flutter_firebase_list/features/signin/domain/repositories/get_users_repository.dart';
import 'package:flutter_firebase_list/features/signin/domain/usecases/get_users.dart';

class GetUsersRepositoryImpl extends GetUsersRepository {
  GetUsersRepositoryImpl(this._remoteSource);

  final GetUsersRemoteSource _remoteSource;

  @override
  Future<Either<List<UserInfo>, GetUsersException>> getUsers() async {
    try {
      return Left(await _remoteSource.getUsers());
    } catch (e, stk) {
      return Right(GetUsersExceptionUnknown(e, stk));
    }
  }
}
