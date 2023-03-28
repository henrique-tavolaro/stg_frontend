import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stg_frontend/core/config/injection.dart';
import 'package:stg_frontend/core/constants/app_texts.dart';
import 'package:stg_frontend/core/design_system/app_colors.dart';
import 'package:stg_frontend/core/design_system/app_textstyle.dart';
import 'package:stg_frontend/core/utils/screen_size.dart';
import 'package:stg_frontend/core/utils/snackbar.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';
import 'package:stg_frontend/presentation/cubit/task_details/task_details_cubit.dart';
import 'package:stg_frontend/presentation/pages/task_details/widgets/custom_button.dart';
import 'package:stg_frontend/presentation/pages/widgets/alert_dialog.dart';
import 'package:stg_frontend/presentation/pages/widgets/alert_dialog_textfield.dart';

class TaskDetailsPage extends StatefulWidget {
  final TaskModel task;

  const TaskDetailsPage({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingControllerSystem =
      TextEditingController();
  bool updating = false;

  bool updated = false;
  late List<String> assignedTo;
  List<String> usersList = ['João', 'Ana', 'Maria', 'José'];
  List<String> responsible = [];
  List<String> systems = [];
  late TaskDetailsCubit cubit;

  @override
  void initState() {
    if (widget.task.documentation != null) {
      _textEditingController.text = widget.task.documentation!;
    }
    assignedTo = widget.task.assignedTo;

    for (var i in assignedTo) {
      if (widget.task.assignedTo.contains(i)) {
        responsible.add(i);
        usersList.remove(i);
      }
    }

    cubit = getIt<TaskDetailsCubit>();

    systems.addAll(widget.task.systems);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.grey200,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            widget.task.name.toUpperCase(),
          ),
          centerTitle: true,
        ),
        body: BlocListener<TaskDetailsCubit, TaskDetailsState>(
          bloc: cubit,
          listener: (context, state) {
            state.maybeWhen(
                updated: () => showSnackbar(context, AppTexts.taskUpdated),
                failed: (_) => showSnackbar(context, AppTexts.internalError),
                orElse: () {});
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: const Text(AppTexts.documentation).h4(),
                      ),
                      if (widget.task.documentation != null)
                        Material(
                          elevation: 4,
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              size: 16,
                            ),
                            onPressed: () {
                              setState(() {
                                updating = true;
                              });
                            },
                          ),
                        )
                    ],
                  ),
                  SizedBox(
                    height: screenSize(context).height / 70,
                  ),
                  SizedBox(
                    width: screenSize(context).width,
                    child: Material(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
                        child: updating || widget.task.documentation == null
                            ? TextField(
                                autofocus: true,
                                controller: _textEditingController,
                                onChanged: (_) {
                                  setState(() {
                                    updated = true;
                                  });
                                },
                                maxLines: null,
                                decoration: widget.task.documentation == null
                                    ? const InputDecoration(
                                        focusedBorder: InputBorder.none,
                                        hintText: AppTexts.typeHere)
                                    : null)
                            : Text(widget.task.documentation!),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize(context).height / 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: const Text(AppTexts.responsible).h4(),
                      ),
                      Container(
                        width: screenSize(context).width / 3,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            hint: const Text(AppTexts.select),
                            isExpanded: true,
                            isDense: true,
                            items: usersList.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            underline: const SizedBox(),
                            onChanged: (value) {
                              setState(() {
                                responsible.add(value!);
                                usersList.remove(value);
                                updated = true;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize(context).height / 70,
                  ),
                  Material(
                    elevation: 4,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: responsible.length,
                      itemBuilder: (context, index) {
                        final item = responsible[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item).h5(),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    updated = true;
                                    responsible.remove(item);
                                    usersList.add(item);
                                  });
                                },
                                icon: const Icon(Icons.person_remove_rounded),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: responsible.isNotEmpty
                        ? screenSize(context).height / 70
                        : 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: const Text(AppTexts.systems).h4(),
                      ),
                      Material(
                        elevation: 4,
                        child: IconButton(
                          icon: const Icon(
                            Icons.note_add_sharp,
                            size: 16,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return MyAlertDialogTextfield(
                                  onClick: () {
                                    setState(
                                      () {
                                        updated = true;
                                        systems.add(
                                            _textEditingControllerSystem.text);
                                        _textEditingControllerSystem.clear();
                                      },
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  text: AppTexts.deleteTask,
                                  controller: _textEditingControllerSystem,
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenSize(context).height / 70),
                  Material(
                    elevation: 4,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: systems.length,
                      itemBuilder: (context, index) {
                        final item = systems[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item).h5(),
                              IconButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      updated = true;
                                      systems.remove(item);
                                    },
                                  );
                                },
                                icon:
                                    const Icon(Icons.highlight_remove_outlined),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: systems.isNotEmpty
                        ? screenSize(context).height / 70
                        : 0,
                  ),
                  Material(
                    elevation: 4,
                    child: ListTile(
                      tileColor: updated ? AppColor.grey200 : null,
                      onTap: () async => updated
                          ? showSnackbar(context, AppTexts.updateFirst)
                          : context.push('/task_list', extra: widget.task),
                      title: const Text(AppTexts.tasks).h4(),
                      subtitle: Text(
                              '${widget.task.tasks.length} ${AppTexts.registered}')
                          .h6(
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic)),
                      trailing: const Icon(Icons.arrow_forward_rounded),
                    ),
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
                                        Navigator.of(context).pop();
                                        context.pop(widget.task.id);
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
                          onClick: updated
                              ? () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return MyAlertDialog(
                                            onClick: () {
                                              cubit.updateTaskUseCase(
                                                  props: UpdateTaskProps(
                                                widget.task.id,
                                                widget.task.previusId,
                                                widget.task.fatherId,
                                                widget.task.name,
                                                responsible,
                                                _textEditingController.text,
                                                systems,
                                              ));
                                              Navigator.of(context).pop();
                                              setState((){
                                                updated = false;
                                              });
                                            },
                                            text: AppTexts.updateTask);
                                      });
                                }
                              : () {},
                          text: AppTexts.update,
                          color:
                              updated ? AppColor.purple600 : AppColor.grey200,
                          textColor: updated ? Colors.white : AppColor.grey400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
