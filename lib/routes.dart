import 'package:flutter/material.dart';
import 'package:flutter_firebase_list/features/signin/domain/entities/user_info.dart';
import 'package:flutter_firebase_list/features/signin/domain/usecases/get_users.dart';
import 'package:flutter_firebase_list/features/signin/presenter/signin_screen.dart';
import 'package:flutter_firebase_list/features/signin/presenter/signin_screen_controller.dart';
import 'package:flutter_firebase_list/features/signup/domain/usecases/signup.dart';
import 'package:flutter_firebase_list/features/signup/presenter/signup_screen.dart';
import 'package:flutter_firebase_list/features/signup/presenter/signup_screen_controller.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/create_task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/delete_task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/get_tasks.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/update_task.dart';
import 'package:flutter_firebase_list/features/tasks_list/presenter/tasks_list_screen.dart';
import 'package:flutter_firebase_list/features/tasks_list/presenter/tasks_list_screen_controller.dart';
import 'package:flutter_firebase_list/features/welcome/presenter/welcome_screen.dart';
import 'package:provider/provider.dart';

enum Routes {
  welcomeScreen,
  signinScreen,
  signupScreen,
  tasksListScreen;

  String get _getRouteName => this == Routes.welcomeScreen ? '/' : name;

  Future<T?> push<T>(BuildContext context, {Object? arguments}) =>
      Navigator.of(context).pushNamed<T>(_getRouteName, arguments: arguments);

  Future<T?> pushReplacement<T>(BuildContext context, {Object? arguments}) =>
      Navigator.of(context)
          .pushReplacementNamed(_getRouteName, arguments: arguments);

  static Route onGenerateRoute(RouteSettings settings) {
    final name = settings.name;

    return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          if (name == '/') return const WelcomeScreen();

          if (name == Routes.signinScreen.name) return _signin(context);

          if (name == Routes.signupScreen.name) return _signup(context);

          if (name == Routes.tasksListScreen.name) {
            return _tasksList(context, settings.arguments as UserInfo);
          }

          throw RouteNotFoundException(settings);
        });
  }

  static Widget _signin(BuildContext context) {
    final getUsers = Provider.of<GetUsers>(context);
    return SigninScreen(controller: SigninScreenController(getUsers));
  }

  static Widget _signup(BuildContext context) {
    final signup = Provider.of<Signup>(context);
    return SignupScreen(controller: SignupScreenController(signup));
  }

  static Widget _tasksList(BuildContext context, UserInfo userInfo) {
    final getTasks = Provider.of<GetTasks>(context);
    final createTask = Provider.of<CreateTask>(context);
    final updateTask = Provider.of<UpdateTask>(context);
    final deleteTask = Provider.of<DeleteTask>(context);

    return TasksListScreen(
        controller: TasksListScreenController(
      userInfo,
      getTasks,
      createTask,
      updateTask,
      deleteTask,
    ));
  }
}

class RouteNotFoundException {
  RouteNotFoundException(this.settings);
  final RouteSettings settings;

  @override
  String toString() => '$runtimeType $settings';
}
