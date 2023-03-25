

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stg_frontend/core/config/injection.dart';
import 'package:stg_frontend/core/constants/app_texts.dart';
import 'package:stg_frontend/core/design_system/app_colors.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/presentation/cubit/task_list/task_list_cubit.dart';
import 'package:stg_frontend/presentation/pages/widgets/alert_dialog_textfield.dart';
import 'package:stg_frontend/presentation/pages/widgets/task_list_tile.dart';

class DepartmentDetailsPage extends StatelessWidget {

  final String department;

  const DepartmentDetailsPage({Key? key, required this.department}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TaskListCubit>()..init(props: FetchTasksByDepartmentProps(department)),
      child: DepartmentDetailsView(department: department,),
    );
  }
}

class DepartmentDetailsView extends StatefulWidget {
  final String department;

  const DepartmentDetailsView({Key? key, required this.department}) : super(key: key);

  @override
  State<DepartmentDetailsView> createState() => _DepartmentDetailsViewState();
}

class _DepartmentDetailsViewState extends State<DepartmentDetailsView> {
  final TextEditingController _textEditingController = TextEditingController();

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
          title: Text(widget.department.toUpperCase()),
        centerTitle: true,),
        body: BlocBuilder<TaskListCubit, TaskListState>(
          builder: (context, state){
            switch(state.status) {
              case TaskListStatus.initial:
                return const SizedBox.shrink();
              case TaskListStatus.loading:
                return const Center(child: CircularProgressIndicator(),);
              case TaskListStatus.loaded:
                return ListView.builder(
                  shrinkWrap: true,
                    itemCount: state.taskList.length,
                    itemBuilder: (context, index){
                      final item = state.taskList[index];
                      return TaskListTile(task: item, onClick: () async {
                         final String? result = await GoRouter.of(context).push<String>('/task_details', extra: item);
                         print('STRING $result');
                         if(result != null){
                           getIt<TaskListCubit>().removeTask(props: DeleteTaskProps(result, null, null));
                         }
                      });
                    });
              case TaskListStatus.failure:
                return Center(child: Text(state.errorMessage.toString()),);

            }
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

                      getIt<TaskListCubit>().createTask(
                          props: CreateTaskProps(text, widget.department, null, null));
                      Navigator.of(context).pop();
                      _textEditingController.clear();
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
