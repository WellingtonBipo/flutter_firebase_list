import 'package:flutter/material.dart';
import 'package:flutter_firebase_list/core/widgets/custom_dialogs.dart';

import 'package:flutter_firebase_list/core/widgets/custom_elevated_button.dart';
import 'package:flutter_firebase_list/core/widgets/custom_text_form_field.dart';
import 'package:flutter_firebase_list/features/signup/presenter/signup_screen_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SignupScreenController controller;

  final nameField = TextEditingController();
  final emailField = TextEditingController();

  Future<void> _doSignup(BuildContext context) async {
    CustomDialogs.showLoading(context);

    VoidCallback showWarning(String text) {
      return () => CustomDialogs.showBottonWarning(context, text);
    }

    final result = await controller.signup(
      name: nameField.text,
      email: emailField.text,
      onNameEmpty: showWarning('Name field shold not be empty'),
      onEmailEmpty: showWarning('Email field shold not be empty'),
      onSuccess: (id) => showWarning('User created => $id')(),
      onEmailAlreadyExist: showWarning('Email already exists'),
      onUnkownError: (e) => showWarning('Unknown error => $e')(),
    );

    Navigator.of(context).pop();

    result();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Signup',
              style: TextStyle(
                color: Colors.white,
              ))),
      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(child: SizedBox.fromSize()),
              CustomTextFormField(label: 'Name', controller: nameField),
              const SizedBox(height: 50),
              CustomTextFormField(label: 'Email', controller: emailField),
              Expanded(child: SizedBox.fromSize()),
              CustomElevatedButton(
                text: 'Signup',
                onPressed: () => _doSignup(context),
              ),
              Expanded(child: SizedBox.fromSize()),
            ],
          ),
        );
      }),
    );
  }
}
