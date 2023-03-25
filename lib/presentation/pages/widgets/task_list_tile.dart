
import 'package:flutter/material.dart';
import 'package:stg_frontend/core/constants/app_texts.dart';
import 'package:stg_frontend/core/design_system/app_textstyle.dart';
import 'package:stg_frontend/core/enums/task_status.dart';
import 'package:stg_frontend/core/utils/date_time_extension.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';

import '../../../core/design_system/app_colors.dart';

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
          subtitle: Text('${AppTexts.createdAt}${task.createdAt.dayMonthYear}').h6(),
          trailing: Column(
            children: [
              const Text(AppTexts.status).h6(),
              const SizedBox(height: 4,),
              CircleAvatar(
                radius: 12,
                backgroundColor: setColor(task.status),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color setColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.Pendente:
        return AppColor.purple600;
      case TaskStatus.EmAndamento:
        return AppColor.yellow500;
      case TaskStatus.Feito:
        return AppColor.green600;
      case TaskStatus.Excluido:
        return AppColor.red500;
    }
  }
}