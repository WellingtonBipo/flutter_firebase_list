import 'package:either_dart/either.dart';

import 'package:flutter_firebase_list/features/signin/domain/entities/user_info.dart';
import 'package:flutter_firebase_list/features/signup/datasource/exceptions/signup_email_already_exists_excpetion.dart';
import 'package:flutter_firebase_list/features/signup/datasource/exceptions/signup_unknown_exception.dart';
import 'package:flutter_firebase_list/features/signup/datasource/sources/remote/signup_remote_source.dart';
import 'package:flutter_firebase_list/features/signup/domain/entities/signup_request.dart';
import 'package:flutter_firebase_list/features/signup/domain/repositories/signup_repository.dart';
import 'package:flutter_firebase_list/features/signup/domain/usecases/signup.dart';

class SignupRepositoryImpl extends SignupRepository {
  SignupRepositoryImpl(this._remoteSource);

  final SignupRemoteSource _remoteSource;

  @override
  Future<Either<UserInfo, SignupException>> signup(
      SignupRequest request) async {
    try {
      if (await _remoteSource.hasUsersWithEmail(request.email)) {
        return Right(SignupEmailAlreadyExistsExcpetion());
      }
      return Left(await _remoteSource.createUser(request));
    } catch (e, stk) {
      return Right(SignupUnknownException(e, stk));
    }
  }
}
