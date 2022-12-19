import 'package:flutter/material.dart';
import 'package:flutter_firebase_list/features/signin/domain/entities/user_id.dart';
import 'package:flutter_firebase_list/features/signin/domain/usecases/get_users.dart';

class SigninScreenController {
  SigninScreenController(this._getUsers);

  final GetUsers _getUsers;

  Future<VoidCallback> getUsers({
    required void Function(List<UserInfo>) onSuccess,
    required void Function(Object) onUnkownError,
  }) async {
    final result = await _getUsers();

    return result.fold<VoidCallback>(
      (left) => () => onSuccess(left),
      (right) => () => onUnkownError(right),
    );
  }
}
