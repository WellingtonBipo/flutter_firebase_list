import 'package:flutter_firebase_list/features/signin/domain/usecases/get_users.dart';

class GetUsersExceptionUnknown extends GetUsersException {
  GetUsersExceptionUnknown(this.exception, this.stackTrace);

  final Object exception;
  final StackTrace stackTrace;

  @override
  String toString() {
    return '$runtimeType\n$exception\n$stackTrace';
  }
}
