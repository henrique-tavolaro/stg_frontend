import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/core/use_case/use_case.dart';
import 'package:stg_frontend/domain/use_cases/task/create_task_use_case.dart';
import 'package:stg_frontend/domain/use_cases/task/delete_task_use_case.dart.dart';
import 'package:stg_frontend/domain/use_cases/task/fetch_tasks_use_case.dart';
import 'package:stg_frontend/domain/use_cases/task/update_task_use_case.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';

part 'task_list_state.dart';

@singleton
class TaskListCubit extends Cubit<TaskListState> {
  final FetchTasksUseCase fetchTasksUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final CreateTaskUseCase createTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;

  TaskListCubit(this.fetchTasksUseCase,
      this.deleteTaskUseCase,
      this.createTaskUseCase,
      this.updateTaskUseCase,) : super(const TaskListState());

  Future<void> fetchTasks() async {
    emit(state.copyWith(status: TaskListStatus.loading));

    final inputEither = await fetchTasksUseCase(props: const NoProps());

    inputEither.fold(
          (l) =>
          emit(state.copyWith(
              status: TaskListStatus.failure, errorMessage: l.message)),
          (r) =>
          emit(state.copyWith(status: TaskListStatus.loaded, taskList: r)),
    );
  }

  Future<void> createTask({required CreateTaskProps props}) async {
    final inputEither = await createTaskUseCase(props: props);
    inputEither.fold(
            (l) =>
            emit(state.copyWith(
                status: TaskListStatus.failure, errorMessage: l.message)),
            (r) {
          final List<TaskModel> updatedTaskList = List.of(state.taskList)
            ..add(r);

          emit(state.copyWith(
            status: TaskListStatus.loaded, taskList: updatedTaskList,),);

        }
    );
  }

  Future<void> deleteTask({required DeleteTaskProps props}) async {

    final inputEither = await deleteTaskUseCase(props: props);
    inputEither.fold(
            (l) =>
            emit(state.copyWith(
                status: TaskListStatus.failure, errorMessage: l.message)),
            (_) {
          final List<TaskModel> updatedTaskList = List.of(state.taskList)
            ..removeWhere((task) => task.id == props.id);

          emit(state.copyWith(
            status: TaskListStatus.loaded, taskList: updatedTaskList,),);

        }
    );
  }
}
