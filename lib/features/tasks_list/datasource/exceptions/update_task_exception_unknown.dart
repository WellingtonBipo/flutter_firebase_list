import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/update_task.dart';

class UpdateTaskExceptionUnknown extends UpdateTaskException {
  UpdateTaskExceptionUnknown(this.exception, this.stackTrace);

  final Object exception;
  final StackTrace stackTrace;

  @override
  String toString() {
    return '$runtimeType\n$exception\n$stackTrace';
  }
}
