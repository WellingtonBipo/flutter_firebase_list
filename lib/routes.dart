import 'package:flutter/material.dart';
import 'package:flutter_firebase_list/features/signup/domain/usecases/signup.dart';
import 'package:flutter_firebase_list/features/signup/presenter/signup_screen.dart';
import 'package:flutter_firebase_list/features/signup/presenter/signup_screen_controller.dart';
import 'package:flutter_firebase_list/features/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

enum Routes {
  welcomeScreen,
  signinScreen,
  signupScreen,
  listTasksScreen;

  String get _getRouteName => this == Routes.welcomeScreen ? '/' : name;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final name = settings.name;

    return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          if (name == '/') return const WelcomeScreen();

          // if (name == Routes.signinScreen.name) return _r(const WelcomeScreen());

          if (name == Routes.signupScreen.name) {
            final signup = Provider.of<Signup>(context);
            return SignupScreen(controller: SignupScreenController(signup));
          }

          // if (name == Routes.listTasksScreen.name) return _r(const WelcomeScreen());

          throw RouteNotFoundException(settings);
        });
  }

  Future<T?> push<T>(BuildContext context) =>
      Navigator.of(context).pushNamed<T>(_getRouteName);
}

class RouteNotFoundException {
  RouteNotFoundException(this.settings);
  final RouteSettings settings;

  @override
  String toString() => '$runtimeType $settings';
}
