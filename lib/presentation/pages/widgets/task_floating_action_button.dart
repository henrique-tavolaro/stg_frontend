
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stg_frontend/core/constants/app_texts.dart';
import 'package:stg_frontend/core/design_system/app_colors.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/presentation/cubit/task_list/task_list_cubit.dart';
import 'package:stg_frontend/presentation/pages/department_details/department_details_page.dart';
import 'package:stg_frontend/presentation/pages/widgets/alert_dialog_textfield.dart';

class TaskFloatingActionButton extends StatelessWidget {
  const TaskFloatingActionButton({
  super.key,
  required TextEditingController textEditingController,
  required this.cubit,
  required this.widget,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;
  final TaskListCubit cubit;
  final DepartmentDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return MyAlertDialogTextfield(
                controller: _textEditingController,
                onClick: () {
                  final text = _textEditingController.text;

                  if(text.isNotEmpty) {
                    cubit.createTask(
                        props: CreateTaskProps(
                            text, widget.department, null, null));
                    context.pop();
                    _textEditingController.clear();
                  }
                },
                text: AppTexts.taskRegister,
              );
            });
      },
      backgroundColor: AppColor.purple600,
      label: const Text(AppTexts.newTask),
      icon: const Icon(Icons.add),
    );
  }
}
