import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/create_task.dart';

class CreateTaskExceptionUnknown extends CreateTaskException {
  CreateTaskExceptionUnknown(this.exception, this.stackTrace);

  final Object exception;
  final StackTrace stackTrace;

  @override
  String toString() {
    return '$runtimeType\n$exception\n$stackTrace';
  }
}
