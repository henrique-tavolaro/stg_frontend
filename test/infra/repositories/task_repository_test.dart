


import 'package:dartz/dartz.dart';
import 'package:dartz_test/dartz_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/external/remote_datasource/task_datasource.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';
import 'package:stg_frontend/infra/repositories/task_repository.dart';

import '../../external/remote_datasource/fakes/task_fake.dart';
import '../../external/remote_datasource/fakes/task_props_fake.dart';

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
  });


  group('create task', () {
    test('should return right', () async {
      when(() => datasource.createTask(props: any(named: 'props')))
          .thenAnswer((_) async => unit);

      final result =
      await sut.createTask(props: CreateTaskProps('name', null, null));

      expect(result, isRight);
      expect(result, isRightThat(unit));
      expect(result.fold(id, id), isA<Unit>());
    });

    test('should throw server failure and return left', () async {
      when(() => datasource.createTask(props: any(named: 'props')))
          .thenThrow(const ServerException(message: '', code: ''));

      final result =
      await sut.createTask(props: CreateTaskProps('name', null, null));

      expect(result.fold(id, id), isA<ServerFailure>());
      expect(result, isLeft);
    });
  });

  group('delete task', () {
    test('should return right', () async {
      when(() => datasource.deleteTask(props: any(named: 'props')))
          .thenAnswer((_) async => unit);

      final result =
      await sut.deleteTask(props: DeleteTaskProps('name', null, null));

      expect(result, isRight);
      expect(result, isRightThat(unit));
      expect(result.fold(id, id), isA<Unit>());
    });

    test('should throw server failure and return left', () async {
      when(() => datasource.deleteTask(props: any(named: 'props')))
          .thenThrow(const ServerException(message: '', code: ''));

      final result =
      await sut.deleteTask(props: DeleteTaskProps('name', null, null));

      expect(result.fold(id, id), isA<ServerFailure>());
      expect(result, isLeft);
    });
  });

  group('fetch task', () {
    test('should return right', () async {
      when(() => datasource.fetchTask(props: any(named: 'props')))
          .thenAnswer((_) async => taskModel);

      final result =
      await sut.fetchTask(props: FetchTaskProps('name', null, null));

      expect(result, isRight);
      expect(result, isRightThat(taskModel));
      expect(result.fold(id, id), isA<TaskModel>());
    });

    test('should throw server failure and return left', () async {
      when(() => datasource.fetchTask(props: any(named: 'props')))
          .thenThrow(const ServerException(message: '', code: ''));

      final result =
      await sut.fetchTask(props: FetchTaskProps('name', null, null));

      expect(result.fold(id, id), isA<ServerFailure>());
      expect(result, isLeft);
    });
  });

  group('update task', () {
    test('should return right', () async {
      when(() => datasource.updateTask(props: any(named: 'props')))
          .thenAnswer((_) async => unit);

      final result =
      await sut.updateTask(props: UpdateTaskProps(
          'id', null, null, null, null, [], null, [], null));

      expect(result, isRight);
      expect(result, isRightThat(unit));
      expect(result.fold(id, id), isA<Unit>());
    });

    test('should throw server failure and return left', () async {
      when(() => datasource.updateTask(props: any(named: 'props')))
          .thenThrow(const ServerException(message: '', code: ''));

      final result =
      await sut.updateTask(props: UpdateTaskProps(
          'id', null, null, null, null, [], null, [], null));

      expect(result.fold(id, id), isA<ServerFailure>());
      expect(result, isLeft);
    });
  });
}