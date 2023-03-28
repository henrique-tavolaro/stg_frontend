import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/domain/use_cases/task/create_task_use_case.dart';
import 'package:stg_frontend/domain/use_cases/task/delete_task_use_case.dart.dart';
import 'package:stg_frontend/domain/use_cases/task/fetch_tasks_by_department_use_case.dart';
import 'package:stg_frontend/domain/use_cases/task/fetch_tasks_use_case.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/presentation/cubit/task_list/task_list_cubit.dart';

import '../../external/remote_datasource/fakes/task_fake.dart';
import '../../external/remote_datasource/fakes/task_props_fake.dart';

class FetchTasksUseCaseMock extends Mock implements FetchTasksUseCase {}

class CreateTaskUseCaseMock extends Mock implements CreateTaskUseCase {}

class FetchTasksByDepartmentMock extends Mock
    implements FetchTasksByDepartmentUseCase {}

class DeleteTaskUseCaseMock extends Mock implements DeleteTaskUseCase {}

void main() {
  final fetchTasksUseCase = FetchTasksUseCaseMock();
  final createTaskUseCase = CreateTaskUseCaseMock();
  final fetchTasksByDepartmentUseCase = FetchTasksByDepartmentMock();
  final deleteTaskUseCase = DeleteTaskUseCaseMock();

  late TaskListCubit sut;

  setUp(() {
    sut = TaskListCubit(fetchTasksUseCase, createTaskUseCase,
        fetchTasksByDepartmentUseCase, deleteTaskUseCase);
    registerFallbackValue(FetchTasksPropsFake());
    registerFallbackValue(FetchTasksByDepartmentPropsFake());
    registerFallbackValue(DeleteTaskPropsFake());
    registerFallbackValue(CreateTaskPropsFake());
  });

  final createTaskProps = CreateTaskProps('id', 'rh', null, null);
  final fetchTasksProps = FetchTasksProps('id');
  final fetchTasksByDepartmentProps = FetchTasksByDepartmentProps("name");
  final deleteTaskProps = DeleteTaskProps('id', null, null);

  test('should emit initial state', () async {
    expect(sut.state, const TaskListState.initial());
  });

  blocTest<TaskListCubit, TaskListState>(
    'should emit list of tasks ',
    setUp: () {
      when(() => fetchTasksUseCase(props: any(named: 'props')))
          .thenAnswer((_) async => Right(taskModelList));
    },
    build: () => sut,
    act: (sut) => sut.fetchTasks(props: fetchTasksProps),
    expect: () => [
      const TaskListState.loading(),
      TaskListState.loaded(taskList: taskModelList)
    ],
  );

  blocTest<TaskListCubit, TaskListState>(
    'should emit error message ',
    setUp: () {
      when(() => fetchTasksUseCase(props: any(named: 'props'))).thenAnswer(
          (_) async =>
              const Left(ServerFailure(message: 'error message', code: '')));
    },
    build: () => sut,
    act: (sut) => sut.fetchTasks(props: fetchTasksProps),
    expect: () => [
      const TaskListState.loading(),
      const TaskListState.failed('error message')
    ],
  );

  blocTest<TaskListCubit, TaskListState>(
    'should emit list of tasks by department ',
    setUp: () {
      when(() => fetchTasksByDepartmentUseCase(props: any(named: 'props')))
          .thenAnswer((_) async => Right(taskModelList));
    },
    build: () => sut,
    act: (sut) =>
        sut.fetchTasksByDepartment(props: fetchTasksByDepartmentProps),
    expect: () => [
      const TaskListState.loading(),
      TaskListState.loaded(taskList: taskModelList)
    ],
  );

  blocTest<TaskListCubit, TaskListState>(
    'should emit error message ',
    setUp: () {
      when(() => fetchTasksByDepartmentUseCase(props: any(named: 'props')))
          .thenAnswer((_) async =>
              const Left(ServerFailure(message: 'error message', code: '')));
    },
    build: () => sut,
    act: (sut) =>
        sut.fetchTasksByDepartment(props: fetchTasksByDepartmentProps),
    expect: () => [
      const TaskListState.loading(),
      const TaskListState.failed('error message')
    ],
  );

  blocTest<TaskListCubit, TaskListState>(
    'should create task and emit list of tasks by department ',
    setUp: () {
      when(() => createTaskUseCase(props: any(named: 'props')))
          .thenAnswer((_) async => Right(taskModel));
    },
    build: () => sut,
    act: (sut) => sut.createTask(props: createTaskProps),
    expect: () => [
      const TaskListState.created(),
      TaskListState.loaded(
        taskList: [taskModel],
      ),
    ],
  );

  blocTest<TaskListCubit, TaskListState>(
    'should emit error message ',
    setUp: () {
      when(() => createTaskUseCase(props: any(named: 'props'))).thenAnswer(
          (_) async =>
              const Left(ServerFailure(message: 'error message', code: '')));
    },
    build: () => sut,
    act: (sut) => sut.createTask(props: createTaskProps),
    expect: () =>
    [
      const TaskListState.failed('error message')
    ],
  );

  blocTest<TaskListCubit, TaskListState>(
    'should delete task and emit list without task deleted ',
    setUp: () {
      sut.taskList = [taskModel];
      when(() => deleteTaskUseCase(props: any(named: 'props')))
          .thenAnswer((_) async => const Right(unit));
    },
    build: () => sut,
    act: (sut) => sut.deleteTask(props: deleteTaskProps),
    expect: () => [
      const TaskListState.deleted(),
      const TaskListState.loaded(
        taskList: [],
      ),
    ],
  );

  blocTest<TaskListCubit, TaskListState>(
    'should emit error message ',
    setUp: () {
      when(() => deleteTaskUseCase(props: any(named: 'props'))).thenAnswer(
              (_) async =>
          const Left(ServerFailure(message: 'error message', code: '')));
    },
    build: () => sut,
    act: (sut) => sut.deleteTask(props: deleteTaskProps),
    expect: () =>
    [
      const TaskListState.failed('error message')
    ],
  );
}
