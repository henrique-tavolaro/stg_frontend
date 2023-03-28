import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/core/network/i_client.dart';
import 'package:stg_frontend/external/remote_datasource/task_datasource.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';
import 'package:stg_frontend/infra/models/tree/tree_model.dart';
import 'fakes/fakes.dart';
import 'fakes/http_client_mock.dart';
import 'fakes/task_fake.dart';
import 'fakes/tree_fake.dart';

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

  final fetchTaskProps = FetchTaskProps('id', null, null);
  final createTaskProps = CreateTaskProps('id', 'rh', null, null);
  final updateTaskProps = UpdateTaskProps(
      'id',
      null,
      null,
      null,
      [],
      null,
      []);
  final fetchTasksProps = FetchTasksProps('id');
  final fetchTasksByDepartmentProps = FetchTasksByDepartmentProps("name");
  final fetchTreeProps = FetchTreeByDepartmentProps('name');
  final deleteTaskProps = DeleteTaskProps('id', null, null);

  group('create task', () {
    test('should create task and return unit', () async {
      when(() => client.post(params: any(named: 'params'))).thenAnswer(
            (_) async =>
            HttpResponse(
              headers: null,
              statusCode: 201,
              data: taskJson,
            ),
      );

      final result =
      await sut.createTask(props: createTaskProps);

      expect(result, isA<TaskModel>());
    });

    test('should throw a server exception if status code not 201', () async {
      when(() => client.post(params: any(named: 'params'))).thenAnswer(
            (_) async =>
            HttpResponse(
              headers: null,
              statusCode: 400,
              data: '',
            ),
      );

      expect(
              () async =>
          await sut.createTask(
            props: createTaskProps,
          ),
          throwsA(isA<ServerException>()));
    });

    test('should throw a server exception', () async {
      when(() => client.post(params: any(named: 'params')))
          .thenThrow(const ServerException(message: 'message'));

      expect(
              () async =>
          await sut.createTask(
            props: createTaskProps,
          ),
          throwsA(isA<ServerException>()));
    });
  });

  group('fetch task', () {
    test('should get task', () async {
      when(() => client.get(params: any(named: 'params'))).thenAnswer(
            (_) async =>
            HttpResponse(
              headers: null,
              statusCode: 200,
              data: taskJson,
            ),
      );

      final result =
      await sut.fetchTask(props: fetchTaskProps);
      expect(result, isA<TaskModel>());
    });

    test('should throw a server exception if status code not 201', () async {
      when(() => client.get(params: any(named: 'params'))).thenAnswer(
            (_) async =>
            HttpResponse(
              headers: null,
              statusCode: 400,
              data: '',
            ),
      );

      expect(
              () async =>
          await sut.fetchTask(props: fetchTaskProps),
          throwsA(isA<ServerException>()));
    });

    test('should throw a server exception', () async {
      when(() => client.get(params: any(named: 'params')))
          .thenThrow(const ServerException(message: 'message'));

      expect(
              () async =>
          await sut.fetchTask(props: fetchTaskProps),
          throwsA(isA<ServerException>()));
    });
  });

  group('update task', () {
    test('should update task and return unit', () async {
      when(() => client.put(params: any(named: 'params'))).thenAnswer(
            (_) async =>
            HttpResponse(
              headers: null,
              statusCode: 200,
              data: 'dummy_data',
            ),
      );

      final result = await sut.updateTask(props: updateTaskProps);

      expect(result, isA<Unit>());
    });

    test('should throw a server exception if status code not 201', () async {
      when(() => client.put(params: any(named: 'params'))).thenAnswer(
            (_) async =>
            HttpResponse(
              headers: null,
              statusCode: 400,
              data: '',
            ),
      );

      expect(() async => await sut.updateTask(props: updateTaskProps),
          throwsA(isA<ServerException>()));
    });

    test('should throw a server exception', () async {
      when(() => client.put(params: any(named: 'params')))
          .thenThrow(const ServerException(message: 'message'));

      expect(() async => await sut.updateTask(props: updateTaskProps),
          throwsA(isA<ServerException>()));
    });
  });

  group('delete task', () {
    test('should delete task and return unit', () async {
      when(() => client.delete(params: any(named: 'params'))).thenAnswer(
            (_) async =>
            HttpResponse(
              headers: null,
              statusCode: 200,
              data: 'dummy_data',
            ),
      );

      final result =
      await sut.deleteTask(props: deleteTaskProps);

      expect(result, isA<Unit>());
    });

    test('should throw a server exception if status code not 201', () async {
      when(() => client.delete(params: any(named: 'params'))).thenAnswer(
            (_) async =>
            HttpResponse(
              headers: null,
              statusCode: 400,
              data: '',
            ),
      );

      expect(
              () async =>
          await sut.deleteTask(props: deleteTaskProps),
          throwsA(isA<ServerException>()));
    });

    test('should throw a server exception', () async {
      when(() => client.put(params: any(named: 'params')))
          .thenThrow(const ServerException(message: 'message'));

      expect(
              () async =>
          await sut.deleteTask(props: deleteTaskProps),
          throwsA(isA<ServerException>()));
    });
  });

  group('fetch tasks', () {
    test('should return list of tasks', () async {
      when(() => client.get(params: any(named: 'params'))).thenAnswer(
            (_) async =>
            HttpResponse(
              headers: null,
              statusCode: 200,
              data: taskModelListJson,
            ),
      );

      final result = await sut.fetchTasks(props: fetchTasksProps);

      expect(result, isA<List<TaskModel>>());
    });

    test('should throw a server exception if status code not 200', () async {
      when(() => client.get(params: any(named: 'params'))).thenAnswer(
            (_) async =>
            HttpResponse(
              headers: null,
              statusCode: 400,
              data: '',
            ),
      );

      expect(() async => await sut.fetchTasks(props: fetchTasksProps),
          throwsA(isA<ServerException>()));
    });

    test('should throw a server exception', () async {
      when(() => client.get(params: any(named: 'params')))
          .thenThrow(const ServerException(message: 'message'));

      expect(() async => await sut.fetchTasks(props: fetchTasksProps),
          throwsA(isA<ServerException>()));
    });
  });

  group('fetch tasks by department', () {
    test('should return list of tasks', () async {
      when(() => client.get(params: any(named: 'params'))).thenAnswer(
            (_) async =>
            HttpResponse(
              headers: null,
              statusCode: 200,
              data: taskModelListJson,
            ),
      );

      final result =
      await sut.fetchTasksByDepartment(props: fetchTasksByDepartmentProps);

      expect(result, isA<List<TaskModel>>());
    });

    test('should throw a server exception if status code not 200', () async {
      when(() => client.get(params: any(named: 'params'))).thenAnswer(
            (_) async =>
            HttpResponse(
              headers: null,
              statusCode: 400,
              data: '',
            ),
      );

      expect(() async =>
      await sut.fetchTasksByDepartment(props: fetchTasksByDepartmentProps),
          throwsA(isA<ServerException>()));
    });

    test('should throw a server exception', () async {
      when(() => client.get(params: any(named: 'params')))
          .thenThrow(const ServerException(message: 'message'));

      expect(() async => await sut.fetchTasksByDepartment(props:
          fetchTasksByDepartmentProps),
      throwsA(isA<ServerException>()));
    });
  });

  group('fetch tree', () {
    test('should return the tree', () async {
      when(() => client.get(params: any(named: 'params'))).thenAnswer(
            (_) async =>
            HttpResponse(
              headers: null,
              statusCode: 200,
              data: treeFake,
            ),
      );

      final result =
      await sut.fetchTreeByDepartment(props: fetchTreeProps);

      expect(result, isA<List<TreeModel>>());
    });

    test('should throw a server exception if status code not 200', () async {
      when(() => client.get(params: any(named: 'params'))).thenAnswer(
            (_) async =>
            HttpResponse(
              headers: null,
              statusCode: 400,
              data: '',
            ),
      );

      expect(() async =>
      await sut.fetchTreeByDepartment(props: fetchTreeProps),
          throwsA(isA<ServerException>()));
    });

    test('should throw a server exception', () async {
      when(() => client.get(params: any(named: 'params')))
          .thenThrow(const ServerException(message: 'message'));

      expect(() async => await sut.fetchTreeByDepartment(props: fetchTreeProps),
          throwsA(isA<ServerException>()));
    });
  });
}
