


import 'package:dartz/dartz.dart';
import 'package:dartz_test/dartz_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/external/remote_datasource/task_datasource.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';
import 'package:stg_frontend/infra/models/tree/tree_model.dart';
import 'package:stg_frontend/infra/repositories/task_repository.dart';

import '../../external/remote_datasource/fakes/task_fake.dart';
import '../../external/remote_datasource/fakes/task_props_fake.dart';
import '../../external/remote_datasource/fakes/tree_fake.dart';

class TaskDatasourceMock extends Mock implements TaskDatasource {}

void main() {
  final datasource = TaskDatasourceMock();

  late TaskRepository sut;

  setUp(() {
    sut = TaskRepository(datasource);
    registerFallbackValue(CreateTaskPropsFake());
    registerFallbackValue(FetchTaskPropsFake());
    registerFallbackValue(DeleteTaskPropsFake());
    registerFallbackValue(UpdateTaskPropsFake());
    registerFallbackValue(FetchTasksPropsFake());
    registerFallbackValue(FetchTasksByDepartmentPropsFake());
    registerFallbackValue(FetchTreePropsFake());
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
    test('should return right', () async {
      when(() => datasource.createTask(props: any(named: 'props')))
          .thenAnswer((_) async => taskModel);

      final result =
      await sut.createTask(props: createTaskProps);

      expect(result, isRight);
      expect(result, isRightThat(taskModel));
      expect(result.fold(id, id), isA<TaskModel>());
    });

    test('should throw server failure and return left', () async {
      when(() => datasource.createTask(props: any(named: 'props')))
          .thenThrow(const ServerException(message: '', code: ''));

      final result =
      await sut.createTask(props: createTaskProps);

      expect(result.fold(id, id), isA<ServerFailure>());
      expect(result, isLeft);
    });
  });

  group('delete task', () {
    test('should return right', () async {
      when(() => datasource.deleteTask(props: any(named: 'props')))
          .thenAnswer((_) async => unit);

      final result =
      await sut.deleteTask(props: deleteTaskProps);

      expect(result, isRight);
      expect(result, isRightThat(unit));
      expect(result.fold(id, id), isA<Unit>());
    });

    test('should throw server failure and return left', () async {
      when(() => datasource.deleteTask(props: any(named: 'props')))
          .thenThrow(const ServerException(message: '', code: ''));

      final result =
      await sut.deleteTask(props: deleteTaskProps);

      expect(result.fold(id, id), isA<ServerFailure>());
      expect(result, isLeft);
    });
  });

  group('fetch task', () {
    test('should return right', () async {
      when(() => datasource.fetchTask(props: any(named: 'props')))
          .thenAnswer((_) async => taskModel);

      final result =
      await sut.fetchTask(props: fetchTaskProps);

      expect(result, isRight);
      expect(result, isRightThat(taskModel));
      expect(result.fold(id, id), isA<TaskModel>());
    });

    test('should throw server failure and return left', () async {
      when(() => datasource.fetchTask(props: any(named: 'props')))
          .thenThrow(const ServerException(message: '', code: ''));

      final result =
      await sut.fetchTask(props: fetchTaskProps);

      expect(result.fold(id, id), isA<ServerFailure>());
      expect(result, isLeft);
    });
  });

  group('update task', () {
    test('should return right', () async {
      when(() => datasource.updateTask(props: any(named: 'props')))
          .thenAnswer((_) async => unit);

      final result =
      await sut.updateTask(props: updateTaskProps);

      expect(result, isRight);
      expect(result, isRightThat(unit));
      expect(result.fold(id, id), isA<Unit>());
    });

    test('should throw server failure and return left', () async {
      when(() => datasource.updateTask(props: any(named: 'props')))
          .thenThrow(const ServerException(message: '', code: ''));

      final result =
      await sut.updateTask(props: updateTaskProps);

      expect(result.fold(id, id), isA<ServerFailure>());
      expect(result, isLeft);
    });
  });

  group('fetch tasks', () {
    test('should return right', () async {
      when(() => datasource.fetchTasks(props: any(named: 'props')))
          .thenAnswer((_) async => taskModelList);

      final result =
      await sut.fetchTasks(props: fetchTasksProps);

      expect(result, isRight);
      expect(result, isRightThat(taskModelList));
      expect(result.fold(id, id), isA<List<TaskModel>>());
    });

    test('should throw server failure and return left', () async {
      when(() => datasource.fetchTasks(props: any(named: 'props')))
          .thenThrow(const ServerException(message: '', code: ''));

      final result =
      await sut.fetchTasks(props: fetchTasksProps);

      expect(result.fold(id, id), isA<ServerFailure>());
      expect(result, isLeft);
    });
  });

  group('fetch tasks by department', () {
    test('should return right', () async {
      when(() => datasource.fetchTasksByDepartment(props: any(named: 'props')))
          .thenAnswer((_) async => taskModelList);

      final result =
      await sut.fetchTasksByDepartment(props: fetchTasksByDepartmentProps);

      expect(result, isRight);
      expect(result, isRightThat(taskModelList));
      expect(result.fold(id, id), isA<List<TaskModel>>());
    });

    test('should throw server failure and return left', () async {
      when(() => datasource.fetchTasksByDepartment(props: any(named: 'props')))
          .thenThrow(const ServerException(message: '', code: ''));

      final result =
      await sut.fetchTasksByDepartment(props: fetchTasksByDepartmentProps);

      expect(result.fold(id, id), isA<ServerFailure>());
      expect(result, isLeft);
    });
  });

  group('fetch tree', () {
    test('should return right', () async {
      when(() => datasource.fetchTreeByDepartment(props: any(named: 'props')))
          .thenAnswer((_) async => treeListFake);

      final result =
      await sut.fetchTreeByDepartment(props: fetchTreeProps);

      expect(result, isRight);
      expect(result, isRightThat(treeListFake));
      expect(result.fold(id, id), isA<List<TreeModel>>());
    });

    test('should throw server failure and return left', () async {
      when(() => datasource.fetchTreeByDepartment(props: any(named: 'props')))
          .thenThrow(const ServerException(message: '', code: ''));

      final result =
      await sut.fetchTreeByDepartment(props: fetchTreeProps);

      expect(result.fold(id, id), isA<ServerFailure>());
      expect(result, isLeft);
    });
  });
}