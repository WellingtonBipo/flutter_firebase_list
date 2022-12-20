import 'package:flutter/material.dart';

import 'package:flutter_firebase_list/core/widgets/custom_elevated_button.dart';
import 'package:flutter_firebase_list/core/widgets/custom_text_form_field.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';

abstract class CustomDialogs {
  static void showLoading(BuildContext context) => showDialog(
        context: context,
        routeSettings: const RouteSettings(name: 'showLoading'),
        barrierDismissible: false,
        builder: (_) => const Center(
            child: SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(),
        )),
      );

  static void showBottonWarning(BuildContext context, String text) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text)),
      );

  static Future<TaskInfoDialog?> showTaskDialog({
    required BuildContext context,
    Task? task,
  }) {
    final titleField = TextEditingController(text: task?.title);
    final descriptionField = TextEditingController(text: task?.description);
    return showDialog<TaskInfoDialog>(
      context: context,
      builder: (_) => Dialog(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              task == null ? 'Create new task' : 'Edit a task',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(label: 'Title', controller: titleField),
            const SizedBox(height: 20),
            CustomTextFormField(
                label: 'Description', controller: descriptionField),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: task == null ? 'Create' : 'Update',
              onPressed: () {
                final newTaskInfo = TaskInfoDialog(
                  title: titleField.text,
                  description: descriptionField.text,
                );
                Navigator.of(context).pop(newTaskInfo);
              },
            ),
          ],
        ),
      )),
    );
  }
}

class TaskInfoDialog {
  TaskInfoDialog({
    required this.title,
    required this.description,
  });
  final String title;
  final String description;
}
