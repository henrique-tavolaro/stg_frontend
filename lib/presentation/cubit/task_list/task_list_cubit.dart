import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/domain/use_cases/task/create_task_use_case.dart';
import 'package:stg_frontend/domain/use_cases/task/fetch_tasks_by_department_use_case.dart';
import 'package:stg_frontend/domain/use_cases/task/fetch_tasks_use_case.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';
import 'package:stg_frontend/presentation/cubit/task_details/task_details_cubit.dart';

part 'task_list_state.dart';

part 'task_list_cubit.freezed.dart';

@factoryMethod
class TaskListCubit extends Cubit<TaskListState> {
  final FetchTasksUseCase fetchTasksUseCase;
  final CreateTaskUseCase createTaskUseCase;
  final FetchTasksByDepartmentUseCase fetchTasksByDepartmentUseCase;

  TaskListCubit(
    this.fetchTasksUseCase,
    this.createTaskUseCase,
    this.fetchTasksByDepartmentUseCase,
  ) : super(const TaskListState.initial());

  List<TaskModel> taskList = [];

  Future<void> fetchTasks() async {
    // emit(TaskListState.loading());
    //
    // final inputEither = await fe
  }

  Future<void> createTask({required CreateTaskProps props}) async {
    final inputEither = await createTaskUseCase(props: props);

    inputEither.fold(
      (l) => TaskListState.failed(l.message),
      (r) async {
        taskList.add(r);
        emit(const TaskListState.created());
        emit(TaskListState.loaded(taskList: taskList));
      }
    );

  }

  Future<void> fetchTasksByDepartment(
      {required FetchTasksByDepartmentProps props}) async {

    emit(const TaskListState.loading());

    final inputEither = await fetchTasksByDepartmentUseCase(props: props);


    inputEither.fold(
      (l) => emit(TaskListState.failed(l.message)),
      (r) {
        final newList = taskList.addAll(r);
        emit(TaskListState.loaded(taskList: r));
      },
    );
  }
}
