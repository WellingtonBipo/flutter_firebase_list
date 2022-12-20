// ignore_for_file: prefer_const_constructors

import 'package:flutter_firebase_list/features/signup/domain/entities/signup_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final data = SignupRequest(name: 'name', email: 'email');
  final dataEqual = SignupRequest(name: 'name', email: 'email');
  final dataDiff = SignupRequest(name: 'name2', email: 'email2');
  test(
    'When compare two equal instances, return true',
    () {
      expect(data, dataEqual);
    },
  );

  test(
    'When compare two different instances, return false',
    () {
      expect(data, isNot(dataDiff));
    },
  );
}
