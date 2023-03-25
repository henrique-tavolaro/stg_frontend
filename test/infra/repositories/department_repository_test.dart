import 'package:dartz_test/dartz_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/external/remote_datasource/department_datasource.dart';
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart';
import 'package:stg_frontend/infra/models/department/department_model.dart';
import 'package:stg_frontend/infra/repositories/department_repository.dart';

import '../../external/remote_datasource/fakes/department_fake.dart';
import '../../external/remote_datasource/fakes/department_props_fake.dart';

class DepartmentDatasourceMock extends Mock implements DepartmentDatasource {}

void main() {
  final datasource = DepartmentDatasourceMock();

  late DepartmentRepository sut;

  setUp(() {
    sut = DepartmentRepository(datasource);
    registerFallbackValue(CreateDepartmentPropsFake());
    registerFallbackValue(DeleteDepartmentPropsFake());
    registerFallbackValue(FetchDepartmentPropsFake());
  });

  group('create department', () {
    test('should return right', () async {
      when(() => datasource.createDepartment(props: any(named: 'props')))
          .thenAnswer((_) async => departmentModel);

      final result =
          await sut.createDepartment(props: CreateDepartmentProps('name'));

      expect(result, isRight);
      expect(result, isRightThat(departmentModel));
      expect(result.fold(id, id), isA<DepartmentModel>());
    });

    test('should throw server failure and return left', () async {
      when(() => datasource.createDepartment(props: any(named: 'props')))
          .thenThrow(const ServerException(message: '', code: ''));

      final result =
      await sut.createDepartment(props: CreateDepartmentProps('name'));

      expect(result.fold(id, id), isA<ServerFailure>());
      expect(result, isLeft);
    });
  });

  group('delete department', () {
    test('should return right', () async {
      when(() => datasource.deleteDepartment(props: any(named: 'props')))
          .thenAnswer((_) async => unit);

      final result =
      await sut.deleteDepartment(props: DeleteDepartmentProps('name'));

      expect(result, isRight);
      expect(result, isRightThat(unit));
      expect(result.fold(id, id), isA<Unit>());
    });

    test('should throw server failure and return left', () async {
      when(() => datasource.deleteDepartment(props: any(named: 'props')))
          .thenThrow(const ServerException(message: '', code: ''));

      final result =
      await sut.deleteDepartment(props: DeleteDepartmentProps('name'));

      expect(result.fold(id, id), isA<ServerFailure>());
      expect(result, isLeft);
    });
  });

  group('fetch department', () {
    test('should return right', () async {
      when(() => datasource.fetchDepartment(props: any(named: 'props')))
          .thenAnswer((_) async => departmentModel);

      final result =
      await sut.fetchDepartment(props: FetchDepartmentProps('name'));

      expect(result, isRight);
      expect(result, isRightThat(departmentModel));
      expect(result.fold(id, id), isA<DepartmentModel>());
    });

    test('should throw server failure and return left', () async {
      when(() => datasource.fetchDepartment(props: any(named: 'props')))
          .thenThrow(const ServerException(message: '', code: ''));

      final result =
      await sut.fetchDepartment(props: FetchDepartmentProps('name'));

      expect(result.fold(id, id), isA<ServerFailure>());
      expect(result, isLeft);
    });
  });

  group('fetch departments', () {
    test('should return right', () async {
      when(() => datasource.fetchDepartments())
          .thenAnswer((_) async => departmentModelList);

      final result =
      await sut.fetchDepartments();

      expect(result, isRight);
      expect(result, isRightThat(departmentModelList));
      expect(result.fold(id, id), isA<List<DepartmentModel>>());
    });

    test('should throw server failure and return left', () async {
      when(() => datasource.fetchDepartments())
          .thenThrow(const ServerException(message: '', code: ''));

      final result =
      await sut.fetchDepartments();

      expect(result.fold(id, id), isA<ServerFailure>());
      expect(result, isLeft);
    });
  });
}
