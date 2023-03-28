import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/domain/use_cases/task/update_task_use_case.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';

part 'task_details_state.dart';

part 'task_details_cubit.freezed.dart';

@injectable
class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  final UpdateTaskUseCase updateTaskUseCase;

  TaskDetailsCubit(
    this.updateTaskUseCase,
  ) : super(const TaskDetailsState.initial());

  Future<void> updateTask({required UpdateTaskProps props}) async {
    final inputEither = await updateTaskUseCase(props: props);

    inputEither.fold(
      (l) => emit(TaskDetailsState.failed(message: l.message)),
      (_) => emit(const TaskDetailsState.updated()),
    );
  }
}
