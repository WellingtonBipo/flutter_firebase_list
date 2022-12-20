import 'package:flutter/material.dart';
import 'package:flutter_firebase_list/core/custom_colors.dart';
import 'package:flutter_firebase_list/core/widgets/custom_dialogs.dart';
import 'package:flutter_firebase_list/features/signin/domain/entities/user_info.dart';

import 'package:flutter_firebase_list/features/signin/presenter/signin_screen_controller.dart';
import 'package:flutter_firebase_list/routes.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SigninScreenController controller;

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  Future<void> _getUsers() async {
    final result = await widget.controller.getUsers();
    if (result == null) return;
    CustomDialogs.showBottonWarning(context, 'Error on get users: $result');
  }

  Future<void> _onTapUser(UserInfo userInfo) async {
    Routes.tasksListScreen.push(context, arguments: userInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Signin',
              style: TextStyle(
                color: Colors.white,
              ))),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const Text(
              'Available Users',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: widget.controller.users,
                builder: (context, value, _) {
                  if (value == null || value.isEmpty) {
                    return Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: value == null
                            ? const CircularProgressIndicator()
                            : const Text('Users not found',
                                style: TextStyle(color: Colors.white)),
                      ),
                    );
                  }

                  return ListView.separated(
                      itemCount: value.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, idx) {
                        return _Tile(
                          userInfo: value[idx],
                          onTap: () => _onTapUser(value[idx]),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends ListTile {
  _Tile({
    required super.onTap,
    required UserInfo userInfo,
  }) : super(
            tileColor: CustomColors.grey,
            title: Text(userInfo.name,
                style: const TextStyle(color: Colors.white)),
            subtitle: Text(userInfo.email,
                style: const TextStyle(color: Colors.white)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Tasks', style: TextStyle(color: Colors.white)),
                Text(userInfo.tasks.length.toString()),
              ],
            ));
}
