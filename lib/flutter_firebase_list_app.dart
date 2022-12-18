import 'package:flutter/material.dart';
import 'package:flutter_firebase_list/core/custom_colors.dart';
import 'package:flutter_firebase_list/injectors.dart';
import 'package:flutter_firebase_list/routes.dart';
import 'package:provider/provider.dart';

class FlutterFirebaseListApp extends StatelessWidget {
  const FlutterFirebaseListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Injectors.providers,
      child: MaterialApp(
        title: 'Flutter Firebase List',
        onGenerateRoute: Routes.onGenerateRoute,
        theme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(backgroundColor: CustomColors.grey),
          scaffoldBackgroundColor: Colors.black,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
