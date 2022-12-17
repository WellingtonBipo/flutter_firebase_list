import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_firebase_list/features/signup/datasource/exceptions/signup_email_already_exists_excpetion.dart';
import 'package:flutter_firebase_list/features/signup/datasource/exceptions/signup_unknown_exception.dart';
import 'package:flutter_firebase_list/features/signup/datasource/models/signup_request_model.dart';

import 'package:flutter_firebase_list/features/signup/domain/entities/user_id.dart';
import 'package:flutter_firebase_list/features/signup/domain/entities/signup_request.dart';
import 'package:flutter_firebase_list/features/signup/domain/repositories/signup_repository.dart';
import 'package:flutter_firebase_list/features/signup/domain/usecases/signup.dart';

class SignupRepositoryImpl extends SignupRepository {
  @override
  Future<Either<UserId, SignupException>> signup(SignupRequest request) async {
    try {
      final users = FirebaseFirestore.instance.collection('users');
      final usersWithSameEmail =
          await users.where('email', isEqualTo: request.email.trim()).get();
      if (usersWithSameEmail.docs.isNotEmpty) {
        return Right(SignupEmailAlreadyExistsExcpetion());
      }
      final result = await users.add(request.toMap());
      return Left(UserId(id: result.id));
    } catch (e, stk) {
      return Right(SignupUnknownException(e, stk));
    }
  }
}
