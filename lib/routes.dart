import 'package:flutter/material.dart';
import 'package:flutter_firebase_list/features/signin/domain/entities/user_id.dart';
import 'package:flutter_firebase_list/features/signin/domain/usecases/get_users.dart';
import 'package:flutter_firebase_list/features/signin/presenter/signin_screen.dart';
import 'package:flutter_firebase_list/features/signin/presenter/signin_screen_controller.dart';
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

          if (name == Routes.signinScreen.name) {
            final getUsers = Provider.of<GetUsers>(context);
            return SigninScreen(controller: SigninScreenController(getUsers));
          }

          if (name == Routes.signupScreen.name) {
            final signup = Provider.of<Signup>(context);
            return SignupScreen(controller: SignupScreenController(signup));
          }

          // if (name == Routes.listTasksScreen.name) {
          //   final signup = Provider.of<Signup>(context);
          //   return SignupScreen(
          //       controller: SignupScreenController(
          //           signup, settings.arguments as UserInfo));
          // }

          throw RouteNotFoundException(settings);
        });
  }

  Future<T?> push<T>(BuildContext context, {Object? arguments}) =>
      Navigator.of(context).pushNamed<T>(_getRouteName, arguments: arguments);
}

class RouteNotFoundException {
  RouteNotFoundException(this.settings);
  final RouteSettings settings;

  @override
  String toString() => '$runtimeType $settings';
}
