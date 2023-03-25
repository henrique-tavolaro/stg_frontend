part of 'department_list_cubit.dart';

enum DepartmentListStatus {
  initial,
  loading,
  loaded,
  failure
}

extension DepartmentListStatusX on DepartmentListStatus {
  bool get isInitial => this == DepartmentListStatus.initial;

  bool get isLoading => this == DepartmentListStatus.loading;

  bool get isSuccess => this == DepartmentListStatus.loaded;

  bool get isFailure => this == DepartmentListStatus.failure;
}

class DepartmentListState extends Equatable {

  final DepartmentListStatus status;
  final List<DepartmentModel> departmentList;
  final String? errorMessage;

  const DepartmentListState({
    this.status = DepartmentListStatus.initial,
    this.departmentList = const [],
    this.errorMessage,
  });

  DepartmentListState copyWith({
    DepartmentListStatus? status,
    List<DepartmentModel>? departmentList,
    String? errorMessage,
  }) {
    return DepartmentListState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      departmentList: departmentList ?? this.departmentList,
    );
  }

  @override
  List<Object?> get props => [status, departmentList, errorMessage];

}
