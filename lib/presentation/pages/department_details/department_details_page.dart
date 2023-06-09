import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stg_frontend/core/config/injection.dart';
import 'package:stg_frontend/core/constants/app_texts.dart';
import 'package:stg_frontend/core/design_system/app_colors.dart';
import 'package:stg_frontend/core/utils/snackbar.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/presentation/cubit/task_list/task_list_cubit.dart';
import 'package:stg_frontend/presentation/pages/department_details/widgets/check_tree_card.dart';
import 'package:stg_frontend/presentation/pages/department_details/widgets/empty_task_page.dart';
import 'package:stg_frontend/presentation/pages/widgets/custom_floating_action_button.dart';
import 'package:stg_frontend/presentation/pages/widgets/task_list_tile.dart';

class DepartmentDetailsPage extends StatefulWidget {
  final String department;

  const DepartmentDetailsPage({Key? key, required this.department})
      : super(key: key);

  @override
  State<DepartmentDetailsPage> createState() => _DepartmentDetailsPageState();
}

class _DepartmentDetailsPageState extends State<DepartmentDetailsPage> {

  final TextEditingController _textEditingController = TextEditingController();
  late TaskListCubit cubit;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    cubit = getIt<TaskListCubit>()
      ..fetchTasksByDepartment(
          props: FetchTasksByDepartmentProps(widget.department));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.grey200,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(onPressed: () {
           context.pop();
          }, icon: const Icon(Icons.arrow_back)),
          title: Text(widget.department.toUpperCase()),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async =>
                      context.push('/tree', extra: widget.department),
                  child: CheckTreeCard(widget: widget),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  thickness: 1,
                  height: 1,
                  color: AppColor.grey900,
                ),
              ),

              BlocConsumer<TaskListCubit, TaskListState>(
                bloc: cubit,
                listener: (context, state) {
                  state.maybeWhen(
                      created: () =>
                          showSnackbar(context, AppTexts.taskCreated),
                      failed: (_) =>
                          showSnackbar(context, AppTexts.internalError),
                      deleted: () =>
                          showSnackbar(context, AppTexts.taskDeleted),
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
                                  final String? result = await context.push<
                                      String>('/task_details', extra: item);
                                  if (result != null) {
                                    cubit.deleteTask(props: DeleteTaskProps(
                                        result, null, null));
                                  }
                                },
                              );
                            },
                          );
                        }
                      }
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: CustomFloatingActionButton(
          textEditingController: _textEditingController,
          onClick: () async {
            final text = _textEditingController.text;

            if(text.isNotEmpty) {
              cubit.createTask(
                  props: CreateTaskProps(
                      text, widget.department, null, null));
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

