// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_firebase_list/core/widgets/custom_elevated_button.dart';
import 'package:flutter_firebase_list/features/signin/domain/entities/user_info.dart';
import 'package:flutter_firebase_list/features/signup/presenter/signup_screen.dart';
import 'package:flutter_firebase_list/features/signup/presenter/signup_screen_controller.dart';
import 'package:flutter_firebase_list/routes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class UserInfoMock extends Mock implements UserInfo {}

class SignupScreenControllerForOnNameEmptyCallBackMock
    implements SignupScreenController {
  @override
  noSuchMethod(Invocation invocation) {
    return Future.value(
        invocation.namedArguments[Symbol('onNameEmpty')] as VoidCallback);
  }
}

class SignupScreenControllerForOnSuccessCallBackMock
    implements SignupScreenController {
  @override
  noSuchMethod(Invocation invocation) {
    return Future.value(
        () => invocation.namedArguments[Symbol('onSuccess')](UserInfoMock()));
  }
}

void main() async {
  testWidgets(
    'When tap on signup buttom without fill name field, '
    'should show a warning banner',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
            home: SignupScreen(
                controller:
                    SignupScreenControllerForOnNameEmptyCallBackMock())),
      );

      final buttom = find.byType(CustomElevatedButton);
      expect(buttom, findsOneWidget);

      await tester.tap(buttom);

      expect(find.byType(SnackBar), findsNothing);

      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
    },
  );

  testWidgets(
    'When tap on signup buttom and controller returns onSuccess callbck, '
    'should navigate to tasksListScreen',
    (tester) async {
      var tasksListScreenCalled = false;
      Route<dynamic> onGenerateRoute(RouteSettings set) {
        if (set.name == Routes.tasksListScreen.name) {
          tasksListScreenCalled = true;
        }
        return MaterialPageRoute(builder: (context) => SizedBox.shrink());
      }

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: onGenerateRoute,
          home: SignupScreen(
              controller: SignupScreenControllerForOnSuccessCallBackMock()),
        ),
      );

      final buttom = find.byType(CustomElevatedButton);
      expect(buttom, findsOneWidget);

      await tester.tap(buttom);

      await tester.pump(Duration(milliseconds: 100));

      expect(tasksListScreenCalled, isTrue);
    },
  );
}
