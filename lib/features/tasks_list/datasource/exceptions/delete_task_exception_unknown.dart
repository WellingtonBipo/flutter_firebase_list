import 'package:flutter_firebase_list/features/tasks_list/domain/usecases/delete_task.dart';

class DeleteTaskExceptionUnknown extends DeleteTaskException {
  DeleteTaskExceptionUnknown(this.exception, this.stackTrace);

  final Object exception;
  final StackTrace stackTrace;

  @override
  String toString() {
    return '$runtimeType\n$exception\n$stackTrace';
  }
}
