import 'package:either_dart/either.dart';

import 'package:flutter_firebase_list/features/signin/domain/entities/user_id.dart';
import 'package:flutter_firebase_list/features/signin/domain/usecases/get_users.dart';

abstract class GetUsersRepository {
  Future<Either<List<UserInfo>, GetUsersException>> getUsers();
}
