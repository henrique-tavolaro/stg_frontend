import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/domain/use_cases/department/create_department_use_case.dart';
import 'package:stg_frontend/domain/use_cases/department/fetch_departments_use_case.dart';
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart';
import 'package:stg_frontend/presentation/cubit/department_list/department_list_cubit.dart';

import '../../external/remote_datasource/fakes/department_fake.dart';
import '../../external/remote_datasource/fakes/department_props_fake.dart';
import '../../external/remote_datasource/fakes/no_props_fake.dart';

class FetchDepartmentsUseCaseMock extends Mock
    implements FetchDepartmentsUseCase {}

class CreateDepartmentUseCaseMock extends Mock
    implements CreateDepartmentUseCase {}

void main() {
  final fetchDepartmentsUseCase = FetchDepartmentsUseCaseMock();
  final createDepartmentUseCase = CreateDepartmentUseCaseMock();

  late DepartmentListCubit sut;

  setUp(() {
    sut = DepartmentListCubit(fetchDepartmentsUseCase, createDepartmentUseCase);
    registerFallbackValue(NoPropsFake());
    registerFallbackValue(CreateDepartmentPropsFake());
  });

  test('should emit initial state', () async {
    expect(sut.state, const DepartmentListState.initial()
    );
  });

  blocTest<DepartmentListCubit, DepartmentListState>(
    'should emit list of departments ',
    setUp: () {
      when(() => fetchDepartmentsUseCase(props: any(named: 'props')))
          .thenAnswer((_) async =>
          Right(departmentModelList)
      );
    },
    build: () => sut,
    act: (sut) => sut.fetchDepartments(),
    expect: () =>
    [
      const DepartmentListState.loading(),
      DepartmentListState.loaded(departmentList: departmentModelList)
    ],);


  blocTest<DepartmentListCubit, DepartmentListState>(
    'should emit error message ',
    setUp: () {
      when(() => fetchDepartmentsUseCase(props: any(named: 'props')))
          .thenAnswer((_) async =>
          const Left(ServerFailure(message: 'error message', code: ''))
      );
    },
    build: () => sut,
    act: (sut) => sut.fetchDepartments(),
    expect: () =>
    [
      const DepartmentListState.loading(),
      const DepartmentListState.failed('error message')
    ],);


  blocTest<DepartmentListCubit, DepartmentListState>(
    'should create department and emit new list of departments ',
    setUp: () {
      when(() => createDepartmentUseCase(props: any(named: 'props')))
          .thenAnswer((_) async =>
          Right(departmentModel)
      );
    },
    build: () => sut,
    act: (sut) => sut.createDepartment(props: CreateDepartmentProps('name')),
    expect: () =>
    [
      const DepartmentListState.created(),
      DepartmentListState.loaded(departmentList: [departmentModel])
    ],);


  blocTest<DepartmentListCubit, DepartmentListState>(
    'should emit error message ',
    setUp: () {
      when(() => createDepartmentUseCase(props: any(named: 'props')))
          .thenAnswer((_) async =>
      const Left(ServerFailure(message: 'error message', code: ''))
      );
    },
    build: () => sut,
    act: (sut) => sut.createDepartment(props: CreateDepartmentProps('name')),
    expect: () =>
    [
      const DepartmentListState.failed('error message')
    ],);
}
