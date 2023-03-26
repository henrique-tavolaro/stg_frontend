part of 'task_details_cubit.dart';

@freezed
class TaskDetailsState with _$TaskDetailsState {
  const factory TaskDetailsState.initial() = _Initial;
  const factory TaskDetailsState.updated() = _Updated;
  const factory TaskDetailsState.failed({required String message}) = _Failed;

}