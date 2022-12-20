import 'package:flutter/material.dart';
import 'package:flutter_firebase_list/features/signin/domain/entities/user_info.dart';
import 'package:flutter_firebase_list/features/signin/domain/usecases/get_users.dart';

class SigninScreenController {
  SigninScreenController(this._getUsers);

  final GetUsers _getUsers;
  final users = ValueNotifier<List<UserInfo>?>(null);

  Future<Object?> getUsers() async {
    final result = await _getUsers();
    return result.fold<Object?>(
      (left) {
        users.value = left..sort((a, b) => a.name.compareTo(b.name));
        return null;
      },
      (right) {
        users.value = [];
        return right;
      },
    );
  }
}
