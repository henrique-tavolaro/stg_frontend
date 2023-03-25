part of 'task_list_cubit.dart';


@freezed
class TaskListState with _$TaskListState {
  const factory TaskListState.initial() = _Initial;
  const factory TaskListState.loading() = _Loading;
  const factory TaskListState.loaded({required List<TaskModel> taskList}) = _Loaded;
  const factory TaskListState.failed(String message) = _Failed;

  const factory TaskListState.creating() = _Creating;
  const factory TaskListState.created() = _Created;
}