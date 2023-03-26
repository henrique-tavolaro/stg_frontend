import 'package:flutter/material.dart';
import 'package:stg_frontend/core/constants/app_texts.dart';
import 'package:stg_frontend/core/design_system/app_textstyle.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';


class TaskListTile extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onClick;

  const TaskListTile({Key? key, required this.task, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 4,
        child: ListTile(
          onTap: onClick,
          title: Text(task.name).h4(),
          trailing: Text('${task.tasks.length} ${AppTexts.subtasks}').h6(style: TextStyle(fontStyle: FontStyle.italic)),
        ),
      ),
    );
  }
}
