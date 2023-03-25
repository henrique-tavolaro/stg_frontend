import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stg_frontend/core/config/injection.dart';
import 'package:stg_frontend/core/constants/app_texts.dart';
import 'package:stg_frontend/core/design_system/app_colors.dart';
import 'package:stg_frontend/core/design_system/app_textstyle.dart';
import 'package:stg_frontend/core/enums/task_status.dart';
import 'package:stg_frontend/core/utils/date_time_extension.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';
import 'package:stg_frontend/presentation/cubit/task_details/task_details_cubit.dart';
import 'package:stg_frontend/presentation/pages/task_details/widgets/custom_button.dart';
import 'package:stg_frontend/presentation/pages/widgets/alert_dialog.dart';

class TaskDetailsPage extends StatelessWidget {
  final TaskModel task;

  const TaskDetailsPage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TaskDetailsCubit>()
        ..fetchTasks(
            props: FetchTaskProps(
          task.id,
          task.previusId,
          task.fatherId,
        )),
      child: TaskDetailsView(
        task: task,
      ),
    );
  }
}

class TaskDetailsView extends StatelessWidget {
  final TaskModel task;

  const TaskDetailsView({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.grey200,
        appBar: AppBar(
          title: Text(task.name.toUpperCase()),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('${AppTexts.createdAt}${task.createdAt.dayMonthYear}'),
              DropDownStatus(
                status: task.status,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onClick: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return MyAlertDialog(
                                  onClick: () {
                                    Navigator.of(context).pop(task.id);
                                    Navigator.of(context).pop(task.id);
                                  },
                                  text: AppTexts.deleteTask);
                            });
                      },
                      text: AppTexts.delete,
                      color: AppColor.red500,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomButton(
                      onClick: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return MyAlertDialog(
                                  onClick: () {
                                    // getIt<TaskDetailsCubit>().()
                                  },
                                  text: AppTexts.updateTask);
                            });
                      },
                      text: AppTexts.update,
                      color: AppColor.purple600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DropDownStatus extends StatefulWidget {
  final TaskStatus status;

  const DropDownStatus({Key? key, required this.status}) : super(key: key);

  @override
  State<DropDownStatus> createState() => _DropDownStatusState();
}

class _DropDownStatusState extends State<DropDownStatus> {
  String? _selectedState;

  @override
  void initState() {
    super.initState();
    _selectedState = widget.status.toString();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedState,
      onChanged: (newValue) {
        setState(() {
          _selectedState = newValue;
        });
      },
      items: [
        DropdownMenuItem(
            value: TaskStatus.Pendente.toString(),
            child: const DropDownStatusItem(
                text: AppTexts.pending, color: AppColor.purple600)),
        DropdownMenuItem(
            value: TaskStatus.EmAndamento.toString(),
            child: const DropDownStatusItem(
                text: AppTexts.doing, color: AppColor.yellow500)),
        DropdownMenuItem(
          value: TaskStatus.Feito.toString(),
          child: const DropDownStatusItem(
              text: AppTexts.done, color: AppColor.green600),
        ),
      ],
    );
  }
}

class DropDownStatusItem extends StatelessWidget {
  final String text;
  final Color color;

  const DropDownStatusItem({Key? key, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        CircleAvatar(
          radius: 8,
          backgroundColor: color,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(text).h5(),
      ],
    );
  }
}
