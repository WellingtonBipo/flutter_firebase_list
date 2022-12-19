import 'package:flutter/material.dart';
import 'package:flutter_firebase_list/features/signin/domain/entities/user_id.dart';
import 'package:flutter_firebase_list/features/signup/datasource/exceptions/signup_email_already_exists_excpetion.dart';
import 'package:flutter_firebase_list/features/signup/domain/entities/signup_request.dart';
import 'package:flutter_firebase_list/features/signup/domain/usecases/signup.dart';

class SignupScreenController {
  SignupScreenController(this._signup);

  final Signup _signup;

  Future<VoidCallback> signup({
    required String name,
    required String email,
    required VoidCallback onNameEmpty,
    required VoidCallback onEmailEmpty,
    required void Function(UserInfo userInfo) onSuccess,
    required VoidCallback onEmailAlreadyExist,
    required void Function(Object) onUnkownError,
  }) async {
    if (name.trim().isEmpty) return onNameEmpty;
    if (email.trim().isEmpty) return onEmailEmpty;

    final request = SignupRequest(
      name: name.trim(),
      email: email.trim(),
    );

    final result = await _signup(request);

    return result.fold<VoidCallback>(
      (left) => () => onSuccess(left),
      (right) => () {
        if (right is SignupEmailAlreadyExistsExcpetion) {
          return onEmailAlreadyExist();
        }
        return onUnkownError(right);
      },
    );
  }
}
