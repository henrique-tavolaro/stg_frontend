

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stg_frontend/core/config/injection.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/presentation/cubit/task_list/task_list_cubit.dart';

class DepartmentDetailsPage extends StatelessWidget {

  final String department;

  const DepartmentDetailsPage({Key? key, required this.department}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TaskListCubit>()..fetchTasksByDepartment(props: FetchTasksByDepartmentProps(department)),
      child: DepartmentDetailsView(department: department,),
    );
  }
}

class DepartmentDetailsView extends StatelessWidget {

  final String department;

  const DepartmentDetailsView({Key? key, required this.department}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(department),),
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
                    return InkWell(
                        onTap: () => context.go('/tasks_page', extra: item.name),
                        child: Text(item.name));
                  });
            case TaskListStatus.failure:
              return Center(child: Text(state.errorMessage.toString()),);

          }
        },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { getIt<TaskListCubit>().createTask(props: CreateTaskProps(
              'Nova tarefa', 'rh', null, null)); },

      ),
    );
  }
}
