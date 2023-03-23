import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/core/network/i_client.dart';
import 'package:stg_frontend/external/remote_datasource/task_datasource.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';

import 'fakes/fakes.dart';
import 'fakes/http_client_mock.dart';
import 'fakes/task_fake.dart';

void main() {
  final client = HttpClientMock();

  late TaskDatasource sut;

  setUp(() {
    sut = TaskDatasource(client);
    registerFallbackValue(HttpGetParamsFake());
    registerFallbackValue(HttpPostParamsFake());
    registerFallbackValue(HttpDeleteParamsFake());
    registerFallbackValue(HttpPutParamsFake());
  });

  group('create task', () {
    test('should create task and return unit', () async {
      when(() => client.post(params: any(named: 'params'))).thenAnswer(
        (_) async => HttpResponse(
          headers: null,
          statusCode: 201,
          data: 'dummy_data',
        ),
      );

      final result =
          await sut.createTask(props: CreateTaskProps('id', null, null));

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
          () async => await sut.createTask(
                props: CreateTaskProps('id', null, null),
              ),
          throwsA(isA<ServerException>()));
    });

    test('should throw a server exception', () async {
      when(() => client.post(params: any(named: 'params')))
          .thenThrow(const ServerException(message: 'message'));

      expect(
          () async => await sut.createTask(
                props: CreateTaskProps('id', null, null),
              ),
          throwsA(isA<ServerException>()));
    });
  });

  group('fetch task', () {
    test('should get task', () async {
      when(() => client.get(params: any(named: 'params'))).thenAnswer(
        (_) async => HttpResponse(
          headers: null,
          statusCode: 200,
          data: taskJson,
        ),
      );

      final result =
          await sut.fetchTask(props: FetchTaskProps('id', null, null));
      expect(result, isA<TaskModel>());
    });

    test('should throw a server exception if status code not 201', () async {
      when(() => client.get(params: any(named: 'params'))).thenAnswer(
        (_) async => HttpResponse(
          headers: null,
          statusCode: 400,
          data: '',
        ),
      );

      expect(
          () async =>
              await sut.fetchTask(props: FetchTaskProps('id', null, null)),
          throwsA(isA<ServerException>()));
    });

    test('should throw a server exception', () async {
      when(() => client.get(params: any(named: 'params')))
          .thenThrow(const ServerException(message: 'message'));

      expect(
          () async =>
              await sut.fetchTask(props: FetchTaskProps('id', null, null)),
          throwsA(isA<ServerException>()));
    });
  });

  group('update task', () {
    test('should update task and return unit', () async {
      when(() => client.put(params: any(named: 'params'))).thenAnswer(
        (_) async => HttpResponse(
          headers: null,
          statusCode: 200,
          data: 'dummy_data',
        ),
      );

      final result = await sut.updateTask(
          props: UpdateTaskProps(
              'id', null, null, null, null, [], null, [], null));

      expect(result, isA<Unit>());
    });

    test('should throw a server exception if status code not 201', () async {
      when(() => client.put(params: any(named: 'params'))).thenAnswer(
            (_) async => HttpResponse(
          headers: null,
          statusCode: 400,
          data: '',
        ),
      );

      expect(
              () async =>
          await sut.updateTask(props: UpdateTaskProps(
              'id', null, null, null, null, [], null, [], null)),
          throwsA(isA<ServerException>()));
    });

    test('should throw a server exception', () async {
      when(() => client.put(params: any(named: 'params')))
          .thenThrow(const ServerException(message: 'message'));

      expect(
              () async =>
          await sut.updateTask(props: UpdateTaskProps(
              'id', null, null, null, null, [], null, [], null)),
          throwsA(isA<ServerException>()));
    });
  });

  group('delete task', () {
    test('should delete task and return unit', () async {
      when(() => client.delete(params: any(named: 'params'))).thenAnswer(
            (_) async => HttpResponse(
          headers: null,
          statusCode: 200,
          data: 'dummy_data',
        ),
      );

      final result =
      await sut.deleteTask(props: DeleteTaskProps('id', null, null));

      expect(result, isA<Unit>());
    });

    test('should throw a server exception if status code not 201', () async {
      when(() => client.delete(params: any(named: 'params'))).thenAnswer(
            (_) async => HttpResponse(
          headers: null,
          statusCode: 400,
          data: '',
        ),
      );

      expect(
              () async =>
          await sut.deleteTask(props: DeleteTaskProps(
              'id', null, null)),
          throwsA(isA<ServerException>()));
    });

    test('should throw a server exception', () async {
      when(() => client.put(params: any(named: 'params')))
          .thenThrow(const ServerException(message: 'message'));

      expect(
              () async =>
          await sut.deleteTask(props: DeleteTaskProps(
              'id', null, null)),
          throwsA(isA<ServerException>()));
    });
  });
}
