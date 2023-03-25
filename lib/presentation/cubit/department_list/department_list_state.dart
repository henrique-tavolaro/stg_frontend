part of 'department_list_cubit.dart';

@freezed
class DepartmentListState with _$DepartmentListState {
  const factory DepartmentListState.initial() = _Initial;
  const factory DepartmentListState.loading() = _Loading;
  const factory DepartmentListState.loaded({required List<DepartmentModel> departmentList}) = _Loaded;
  const factory DepartmentListState.failed(String message) = _Failed;

  const factory DepartmentListState.creating() = _Creating;
  const factory DepartmentListState.created() = _Created;
}