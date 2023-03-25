part of 'task_details_cubit.dart';

enum TaskDetailsStatus {
  initial,
  loading,
  loaded,
  failure
}

extension TaskDetailsStatusX on TaskDetailsStatus {
  bool get isInitial => this == TaskDetailsStatus.initial;

  bool get isLoading => this == TaskDetailsStatus.loading;

  bool get isSuccess => this == TaskDetailsStatus.loaded;

  bool get isFailure => this == TaskDetailsStatus.failure;
}

class TaskDetailsState extends Equatable {

  final TaskDetailsStatus status;
  final TaskModel? task;
  final String? errorMessage;

  const TaskDetailsState({
    this.status = TaskDetailsStatus.initial,
    this.task,
    this.errorMessage,
  });

  TaskDetailsState copyWith({
    TaskDetailsStatus? status,
    TaskModel? task,
    String? errorMessage,
  }) {
    return TaskDetailsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      task: task ?? this.task,
    );
  }

  @override
  List<Object?> get props => [status, task, errorMessage];

}
