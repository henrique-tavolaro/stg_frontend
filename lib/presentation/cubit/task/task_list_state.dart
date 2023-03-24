part of 'task_list_cubit.dart';

enum TaskListStatus {
  initial,
  loading,
  loaded,
  failure
}

extension TaskListStatusX on TaskListStatus {
  bool get isInitial => this == TaskListStatus.initial;

  bool get isLoading => this == TaskListStatus.loading;

  bool get isSuccess => this == TaskListStatus.loaded;

  bool get isFailure => this == TaskListStatus.failure;
}

class TaskListState extends Equatable {

  final TaskListStatus status;
  final List<TaskModel> taskList;
  final String? errorMessage;

  const TaskListState({
    this.status = TaskListStatus.initial,
    this.taskList = const [],
    this.errorMessage,
  });

  TaskListState copyWith({
    TaskListStatus? status,
    List<TaskModel>? taskList,
    String? errorMessage,
  }) {
    return TaskListState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      taskList: taskList ?? this.taskList,
    );
  }

  @override
  List<Object?> get props => [status, taskList, errorMessage];

}
