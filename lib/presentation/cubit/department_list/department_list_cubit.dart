import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/domain/use_cases/department/create_department_use_case.dart';
import 'package:stg_frontend/domain/use_cases/department/fetch_departments_use_case.dart';
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart';
import 'package:stg_frontend/infra/models/department/department_model.dart';

import '../../../core/use_case/use_case.dart';

part 'department_list_state.dart';

part 'department_list_cubit.freezed.dart';

@singleton
class DepartmentListCubit extends Cubit<DepartmentListState> {
  final FetchDepartmentsUseCase fetchDepartmentsUseCase;
  final CreateDepartmentUseCase createDepartmentUseCase;

  DepartmentListCubit(
    this.fetchDepartmentsUseCase,
    this.createDepartmentUseCase,
  ) : super(const DepartmentListState.initial());

  List<DepartmentModel> departmentList = [];

  Future<void> fetchDepartments() async {
    emit(const DepartmentListState.loading());

    final inputEither = await fetchDepartmentsUseCase(props: const NoProps());

    inputEither.fold(
      (l) => emit(DepartmentListState.failed(l.message)),
      (r) {
        departmentList.addAll(r);
        emit(DepartmentListState.loaded(departmentList: departmentList));
      },
    );
  }

  Future<void> createDepartment({required CreateDepartmentProps props}) async {
    final inputEither = await createDepartmentUseCase(props: props);

    inputEither.fold(
        (l) => emit(
              DepartmentListState.failed(l.message),
            ), (r) {
      departmentList.add(r);
      emit(
        const DepartmentListState.created(),
      );
      emit(
        DepartmentListState.loaded(
          departmentList: departmentList,
        ),
      );
    });
  }
}
