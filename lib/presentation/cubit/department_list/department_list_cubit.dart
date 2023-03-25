import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/core/use_case/use_case.dart';
import 'package:stg_frontend/domain/use_cases/department/create_department_use_case.dart';
import 'package:stg_frontend/domain/use_cases/department/delete_department_use_case.dart.dart';
import 'package:stg_frontend/domain/use_cases/department/fetch_department_use_case.dart';
import 'package:stg_frontend/domain/use_cases/department/fetch_departments_use_case.dart';
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart';
import 'package:stg_frontend/infra/models/department/department_model.dart';

part 'department_list_state.dart';

@singleton
class DepartmentListCubit extends Cubit<DepartmentListState> {
  final FetchDepartmentsUseCase fetchDepartmentsUseCase;
  final DeleteDepartmentUseCase deleteDepartmentUseCase;
  final CreateDepartmentUseCase createDepartmentUseCase;

  DepartmentListCubit(this.fetchDepartmentsUseCase,
      this.deleteDepartmentUseCase,
      this.createDepartmentUseCase,) : super(const DepartmentListState());

  Future<void> fetchDepartments() async {
    emit(state.copyWith(status: DepartmentListStatus.loading));

    final inputEither = await fetchDepartmentsUseCase(props: const NoProps());

    inputEither.fold(
          (l) =>
          emit(state.copyWith(
              status: DepartmentListStatus.failure, errorMessage: l.message)),
          (r) =>
          emit(state.copyWith(status: DepartmentListStatus.loaded, departmentList: r)),
    );
  }

  Future<void> createDepartment({required CreateDepartmentProps props}) async {
    emit(state.copyWith(status: DepartmentListStatus.loading));

    final inputEither = await createDepartmentUseCase(props: props);

    inputEither.fold(
            (l) =>
            emit(state.copyWith(
                status: DepartmentListStatus.failure, errorMessage: l.message)),
            (r) {
          final List<DepartmentModel> updatedDepartmentList = List.of(state.departmentList)
            ..add(r);

          emit(state.copyWith(
            status: DepartmentListStatus.loaded, departmentList: updatedDepartmentList,),);

        }
    );
  }

  Future<void> deleteDepartment({required DeleteDepartmentProps props}) async {

    final inputEither = await deleteDepartmentUseCase(props: props);
    inputEither.fold(
            (l) =>
            emit(state.copyWith(
                status: DepartmentListStatus.failure, errorMessage: l.message)),
            (_) {
          final List<DepartmentModel> updatedDepartmentList = List.of(state.departmentList)
            ..removeWhere((department) => department.id == props.id);

          emit(state.copyWith(
            status: DepartmentListStatus.loaded, departmentList: updatedDepartmentList,),);
        }
    );
  }
}
