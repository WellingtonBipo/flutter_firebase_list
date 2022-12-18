import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_firebase_list/flutter_firebase_list_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runZonedGuarded(
    () => runApp(const FlutterFirebaseListApp()),
    (e, stk) => log('runZonedGuarded\n$e\n$stk'),
  );
}
