import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/domain/use_cases/task/delete_task_use_case.dart.dart';
import 'package:stg_frontend/domain/use_cases/task/fetch_task_use_case.dart';
import 'package:stg_frontend/domain/use_cases/task/update_task_use_case.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';

part 'task_details_state.dart';

@singleton
class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  final FetchTaskUseCase fetchTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;

  TaskDetailsCubit(
    this.fetchTaskUseCase,
    this.deleteTaskUseCase,
    this.updateTaskUseCase,
  ) : super(const TaskDetailsState());

  Future<void> fetchTasks({required FetchTaskProps props}) async {
    emit(state.copyWith(status: TaskDetailsStatus.loading));

    final inputEither = await fetchTaskUseCase(props: props);

    inputEither.fold(
      (l) => emit(state.copyWith(
          status: TaskDetailsStatus.failure, errorMessage: l.message)),
      (r) => emit(state.copyWith(status: TaskDetailsStatus.loaded, task: r)),
    );
  }

  Future<void> deleteTask({required DeleteTaskProps props}) async {
    final inputEither = await deleteTaskUseCase(props: props);
    inputEither.fold(
        (l) => emit(state.copyWith(
            status: TaskDetailsStatus.failure, errorMessage: l.message)), (_) {
         emit(
        state.copyWith(
          status: TaskDetailsStatus.loaded,
        ),
      );
    });
  }

}
