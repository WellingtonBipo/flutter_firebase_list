import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/get_tasks.dart';

class GetTasksExceptionUnknown extends GetTasksException {
  GetTasksExceptionUnknown(this.exception, this.stackTrace);

  final Object exception;
  final StackTrace stackTrace;

  @override
  String toString() {
    return '$runtimeType\n$exception\n$stackTrace';
  }
}
