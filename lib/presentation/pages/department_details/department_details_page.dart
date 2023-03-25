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
import 'package:stg_frontend/presentation/pages/widgets/alert_dialog_textfield.dart';
import 'package:stg_frontend/presentation/pages/widgets/task_list_tile.dart';

class DepartmentDetailsPage extends StatelessWidget {
  final String department;

  const DepartmentDetailsPage({Key? key, required this.department})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TaskListCubit>()
        ..fetchTasksByDepartment(
            props: FetchTasksByDepartmentProps(department)),
      child: DepartmentDetailsView(
        department: department,
      ),
    );
  }
}

class DepartmentDetailsView extends StatefulWidget {
  final String department;

  const DepartmentDetailsView({Key? key, required this.department})
      : super(key: key);

  @override
  State<DepartmentDetailsView> createState() => _DepartmentDetailsViewState();
}

class _DepartmentDetailsViewState extends State<DepartmentDetailsView> {
  final TextEditingController _textEditingController = TextEditingController();
  late TaskListCubit cubit;

  @override
  void initState() {
    cubit = getIt<TaskListCubit>()..fetchTasksByDepartmentUseCase(props: FetchTasksByDepartmentProps(widget.department));
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    cubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.grey200,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_back)),
          title: Text(widget.department.toUpperCase()),
          centerTitle: true,
        ),
        body: BlocBuilder<TaskListCubit, TaskListState>(

          builder: (context, state) {
            return state.maybeWhen(
              initial: () => const SizedBox.shrink(),
              orElse: () => Center(child: const EmptyTaskPage()),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (taskList) {
                if(taskList.isEmpty){
                  return  const EmptyTaskPage();
                } else {
                 return  ListView.builder(
                    shrinkWrap: true,
                    itemCount: taskList.length,
                    itemBuilder: (context, index) {
                      final item = taskList[index];
                      return TaskListTile(
                        task: item,
                        onClick: () async {
                          context.push('/task_details', extra: item);
                        },
                      );
                    },
                  );
                }

              }
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return MyAlertDialogTextfield(
                    controller: _textEditingController,
                    onClick: () {
                      final text = _textEditingController.text;

                      if(text.isNotEmpty) {
                        getIt<TaskListCubit>().createTask(
                            props: CreateTaskProps(
                                text, widget.department, null, null));
                        Navigator.of(context).pop();
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
        ),
      ),
    );
  }
}
