import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/domain/use_cases/task/create_task_use_case.dart';
import 'package:stg_frontend/domain/use_cases/task/delete_task_use_case.dart.dart';
import 'package:stg_frontend/domain/use_cases/task/fetch_tasks_by_department_use_case.dart';
import 'package:stg_frontend/domain/use_cases/task/fetch_tasks_use_case.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';

part 'task_list_state.dart';

part 'task_list_cubit.freezed.dart';

@injectable
class TaskListCubit extends Cubit<TaskListState> {
  final FetchTasksUseCase fetchTasksUseCase;
  final CreateTaskUseCase createTaskUseCase;
  final FetchTasksByDepartmentUseCase fetchTasksByDepartmentUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  TaskListCubit(this.fetchTasksUseCase, this.createTaskUseCase,
      this.fetchTasksByDepartmentUseCase, this.deleteTaskUseCase)
      : super(const TaskListState.initial());

  List<TaskModel> taskList = [];

  Future<void> fetchTasks({required FetchTasksProps props}) async {
    emit(const TaskListState.loading());

    final inputEither = await fetchTasksUseCase(props: props);

    inputEither.fold(
      (l) => emit(TaskListState.failed(l.message)),
      (r) {
        taskList.addAll(r);
        emit(TaskListState.loaded(taskList: taskList));
      },
    );
  }

  Future<void> createTask({required CreateTaskProps props}) async {
    final inputEither = await createTaskUseCase(props: props);

    inputEither.fold((l) => emit(TaskListState.failed(l.message)), (r) async {
      taskList.add(r);
      emit(const TaskListState.created());
      emit(TaskListState.loaded(taskList: taskList));
    });
  }

  Future<void> fetchTasksByDepartment(
      {required FetchTasksByDepartmentProps props}) async {
    emit(const TaskListState.loading());

    final inputEither = await fetchTasksByDepartmentUseCase(props: props);

    inputEither.fold(
      (l) => emit(TaskListState.failed(l.message)),
      (r) {
        taskList.addAll(r);
        emit(TaskListState.loaded(taskList: taskList));
      },
    );
  }

  Future<void> deleteTask({required DeleteTaskProps props}) async {
    final inputEither = await deleteTaskUseCase(props: props);

    inputEither.fold(
      (l) => emit(TaskListState.failed(l.message)),
      (r) {
        taskList.removeWhere((task) => task.id == props.id);
        emit(const TaskListState.deleted());
        emit(TaskListState.loaded(taskList: taskList));
      },
    );
  }
}
