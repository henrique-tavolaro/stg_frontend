import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/core/network/i_client.dart';
import 'package:stg_frontend/external/remote_datasource/department_datasource.dart';
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart';
import 'package:stg_frontend/infra/models/department/department_model.dart';
import 'fakes/department_fake.dart';
import 'fakes/fakes.dart';
import 'fakes/http_client_mock.dart';

void main() {
  final client = HttpClientMock();

  late DepartmentDatasource sut;

  setUp(() {
    sut = DepartmentDatasource(client);
    registerFallbackValue(HttpGetParamsFake());
    registerFallbackValue(HttpPostParamsFake());
    registerFallbackValue(HttpDeleteParamsFake());
  });

  group('create department', () {
    test('should create department and return unit', () async {
      when(() => client.post(params: any(named: 'params'))).thenAnswer(
        (_) async => HttpResponse(
          headers: null,
          statusCode: 201,
          data: 'dummy_data',
        ),
      );

      final result =
          await sut.createDepartment(props: CreateDepartmentProps('name'));

      expect(result, isA<Unit>());
    });

    test('should throw a server exception if status code not 201', () async {
      when(() => client.post(params: any(named: 'params'))).thenAnswer(
        (_) async => HttpResponse(
          headers: null,
          statusCode: 400,
          data: '',
        ),
      );

      expect(
        () async => await sut.createDepartment(
          props: CreateDepartmentProps('name'),
        ), throwsA(isA<ServerException>()));
    });

    test('should throw a server exception', () async {
      when(() => client.post(params: any(named: 'params')))
          .thenThrow(const ServerException(message: 'message'));

      expect(
              () async => await sut.createDepartment(
            props: CreateDepartmentProps('name'),
          ), throwsA(isA<ServerException>()));
    });
  });

  group('fetch department', () {
    test('should return department', () async {
      when(() => client.get(params: any(named: 'params'))).thenAnswer(
            (_) async => HttpResponse(
          headers: null,
          statusCode: 200,
          data: departmentJson,
        ),
      );

      final result = await sut.fetchDepartment(props: FetchDepartmentProps('id'));
      expect(result, isA<DepartmentModel>());
    });

    test('should throw a server exception if status code not 200', () async {
      when(() => client.get(params: any(named: 'params'))).thenAnswer(
        (_) async => HttpResponse(
          headers: null,
          statusCode: 400,
          data: '',
        ),
      );

      expect(
              () async => await sut.fetchDepartment(
            props: FetchDepartmentProps('id'),
          ), throwsA(isA<ServerException>()));
    });

    test('should throw a server exception', () async {
      when(() => client.get(params: any(named: 'params')))
          .thenThrow(const ServerException(message: 'message'));

      expect(
              () async => await sut.fetchDepartment(
            props: FetchDepartmentProps('id'),
          ), throwsA(isA<ServerException>()));
    });
  });

  group('fetch departments', () {
    test('should return list of departments', () async {
      when(() => client.get(params: any(named: 'params'))).thenAnswer(
            (_) async => HttpResponse(
          headers: null,
          statusCode: 200,
          data: departmentListJson,
        ),
      );

      final result = await sut.fetchDepartments();

      expect(result, isA<List<DepartmentModel>>());
    });

    test('should throw a server exception if status code not 200', () async {
      when(() => client.get(params: any(named: 'params'))).thenAnswer(
        (_) async => HttpResponse(
          headers: null,
          statusCode: 400,
          data: '',
        ),
      );

      expect(
              () async => await sut.fetchDepartments(),
          throwsA(isA<ServerException>()));
    });

    test('should throw a server exception', () async {
      when(() => client.get(params: any(named: 'params')))
          .thenThrow(const ServerException(message: 'message'));

      expect(
              () async => await sut.fetchDepartments(),
          throwsA(isA<ServerException>()));
    });
  });

  group('delete departments', () {
    test('should delete department and return unit', () async {
      when(() => client.delete(params: any(named: 'params'))).thenAnswer(
            (_) async => HttpResponse(
          headers: null,
          statusCode: 200,
          data: 'dummy data',
        ),
      );

      final result =
      await sut.deleteDepartment(props: DeleteDepartmentProps('id'));

      expect(result, isA<Unit>());
    });

    test('should throw a server exception if status code not 200', () async {
      when(() => client.delete(params: any(named: 'params'))).thenAnswer(
        (_) async => HttpResponse(
          headers: null,
          statusCode: 400,
          data: '',
        ),
      );

      expect(
              () async => await sut.deleteDepartment(props: DeleteDepartmentProps('id')),
          throwsA(isA<ServerException>()));
    });

    test('should throw a server exception', () async {
      when(() => client.get(params: any(named: 'params')))
          .thenThrow(const ServerException(message: 'message'));

      expect(
              () async => await sut.deleteDepartment(props: DeleteDepartmentProps('id')),
          throwsA(isA<ServerException>()));
    });
  });
}
