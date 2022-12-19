import 'package:flutter/material.dart';
import 'package:flutter_firebase_list/core/widgets/custom_elevated_button.dart';
import 'package:flutter_firebase_list/routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const Expanded(child: SizedBox.shrink()),
          const Text('Welcome!',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          const Expanded(child: SizedBox.shrink()),
          CustomElevatedButton(
            text: 'Signin',
            onPressed: () => Routes.signinScreen.push(context),
          ),
          const SizedBox(height: 50),
          CustomElevatedButton(
            text: 'Signup',
            onPressed: () => Routes.signupScreen.push(context),
          ),
          const Expanded(child: SizedBox.shrink()),
        ],
      ),
    ));
  }
}
