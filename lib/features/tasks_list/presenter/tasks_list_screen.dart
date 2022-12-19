import 'package:flutter/material.dart';

import 'package:flutter_firebase_list/core/custom_colors.dart';
import 'package:flutter_firebase_list/core/extensions/datetime_ext.dart';
import 'package:flutter_firebase_list/core/widgets/custom_dialogs.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task.dart';
import 'package:flutter_firebase_list/features/tasks_list/domain/entities/task_info.dart';
import 'package:flutter_firebase_list/features/tasks_list/presenter/tasks_list_screen_controller.dart';

class TasksListScreen extends StatefulWidget {
  const TasksListScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TasksListScreenController controller;

  @override
  State<TasksListScreen> createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  @override
  void initState() {
    super.initState();
    _getTasks();
  }

  Future<void> _getTasks() async {
    final result = await widget.controller.getTasks();
    if (result == null) return;
    CustomDialogs.showBottonWarning(context, 'Error on get tasks: $result');
  }

  Future<void> _createTask() async {
    final task = await CustomDialogs.showTaskDialog(context: context);
    if (task == null) return;
    CustomDialogs.showLoading(context);
    final taskInfo = TaskInfo(
      userId: widget.controller.userInfo.id,
      title: task.title,
      description: task.description,
    );
    final result = await widget.controller.createTask(taskInfo);
    Navigator.of(context).pop();
    if (result == null) return;
    CustomDialogs.showBottonWarning(context, 'Error on create task: $result');
  }

  Future<void> _onTapUpdate(Task task) async {
    final newTaskInfo =
        await CustomDialogs.showTaskDialog(context: context, task: task);
    if (newTaskInfo == null) return;
    final newTask = Task(
      id: task.id,
      title: newTaskInfo.title,
      description: newTaskInfo.description,
      usersIds: task.usersIds,
      createdAt: task.createdAt,
      updatedAt: DateTime.now(),
    );
    CustomDialogs.showLoading(context);
    final result = await widget.controller.updateTask(newTask);
    Navigator.of(context).pop();
    if (result == null) return;
    CustomDialogs.showBottonWarning(context, 'Error on update task: $result');
  }

  Future<void> _onTapDelete(Task task) async {
    CustomDialogs.showLoading(context);
    final result = await widget.controller.deleteTask(task);
    Navigator.of(context).pop();
    if (result == null) return;
    CustomDialogs.showBottonWarning(context, 'Error on delete task: $result');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Tasks',
              style: TextStyle(
                color: Colors.white,
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTask,
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: widget.controller.tasks,
                builder: (context, value, _) {
                  if (value == null || value.isEmpty) {
                    return Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: value == null
                            ? const CircularProgressIndicator()
                            : const Text('There are no tasks',
                                style: TextStyle(color: Colors.white)),
                      ),
                    );
                  }

                  return ListView.separated(
                      itemCount: value.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, idx) {
                        return _Tile(
                          task: value[idx],
                          onTapUpdate: _onTapUpdate,
                          onTapDelete: _onTapDelete,
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends Container {
  _Tile({
    required Task task,
    required Function(Task) onTapUpdate,
    required Function(Task) onTapDelete,
  }) : super(
            color: CustomColors.grey,
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        task.description,
                        style: const TextStyle(color: Colors.white),
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Created: ${task.createdAt.toLocal().format}',
                        style: const TextStyle(color: Colors.white),
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        'Update: ${task.updatedAt.toLocal().format}',
                        style: const TextStyle(color: Colors.white),
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => onTapUpdate(task),
                  icon: const Icon(Icons.update),
                  color: Colors.blue,
                ),
                IconButton(
                  onPressed: () => onTapDelete(task),
                  icon: const Icon(Icons.delete_forever),
                  color: Colors.red,
                ),
              ],
            ));
}
