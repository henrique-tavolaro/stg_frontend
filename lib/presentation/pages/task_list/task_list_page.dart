import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stg_frontend/core/config/injection.dart';
import 'package:stg_frontend/core/constants/app_texts.dart';
import 'package:stg_frontend/core/design_system/app_colors.dart';
import 'package:stg_frontend/core/utils/snackbar.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';
import 'package:stg_frontend/presentation/cubit/task_list/task_list_cubit.dart';
import 'package:stg_frontend/presentation/pages/department_details/widgets/empty_task_page.dart';
import 'package:stg_frontend/presentation/pages/widgets/custom_floating_action_button.dart';
import 'package:stg_frontend/presentation/pages/widgets/task_list_tile.dart';

class TaskListPage extends StatefulWidget {
  final TaskModel task;

  const TaskListPage({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final TextEditingController _textEditingController = TextEditingController();
  late TaskListCubit cubit;

  @override
  void initState() {
    cubit = getIt<TaskListCubit>()
      ..fetchTasks(
          props: FetchTasksProps(widget.task.id));

    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
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
              icon: const Icon(Icons.arrow_back)),
          title: Text(widget.task.name.toUpperCase()),
          centerTitle: true,
        ),
        body: BlocConsumer<TaskListCubit, TaskListState>(
          bloc: cubit,
          listener: (context, state) {
            state.maybeWhen(
                created: () => showSnackbar(context, AppTexts.taskCreated),
                failed: (_) => showSnackbar(context, AppTexts.internalError),
                deleted: () => showSnackbar(context, AppTexts.taskDeleted),
                orElse: () {});
          },
          builder: (context, state) {
            return state.maybeWhen(
                initial: () => const SizedBox.shrink(),
                orElse: () => const EmptyTaskPage(),
                loading: () =>
                const Center(
                  child: CircularProgressIndicator(),
                ),
                loaded: (taskList) {
                  if (taskList.isEmpty) {
                    return const EmptyTaskPage();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: taskList.length,
                      itemBuilder: (context, index) {
                        final item = taskList[index];
                        return TaskListTile(
                          task: item,
                          onClick: () async {
                            context.push<String>('/task_details', extra: item);
                          },
                        );
                      },
                    );
                  }
                });
          },
        ),
        floatingActionButton: CustomFloatingActionButton(
          textEditingController: _textEditingController,
          onClick: () async {

            final text = _textEditingController.text;

            if (text.isNotEmpty) {
              cubit.createTask(
                props: CreateTaskProps(
                  text,
                  widget.task.department,
                  widget.task.id,
                  widget.task.fatherId ?? widget.task.id,
                ),
              );
              Navigator.of(context).pop();
              _textEditingController.clear();
            }
          },
          dialogText: AppTexts.taskRegister,
          buttonText: AppTexts.newTask,),
      ),
    );
  }
}