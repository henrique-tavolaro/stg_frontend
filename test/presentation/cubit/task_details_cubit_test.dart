

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/domain/use_cases/task/update_task_use_case.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/presentation/cubit/task_details/task_details_cubit.dart';

import '../../external/remote_datasource/fakes/task_props_fake.dart';

class UpdateTaskUseCaseMock extends Mock implements UpdateTaskUseCase {}


void main() {
  final useCase = UpdateTaskUseCaseMock();
  late TaskDetailsCubit sut;

  setUp(() {
    sut = TaskDetailsCubit(useCase);
    registerFallbackValue(UpdateTaskPropsFake());
  });

  final updateTaskProps = UpdateTaskProps(
      'id',
      null,
      null,
      null,
      [],
      null,
      []);

  test('should emit initial state', () async {
    expect(sut.state, const TaskDetailsState.initial()
    );
  });

  blocTest<TaskDetailsCubit, TaskDetailsState>(
    'should emit message updated ',
    setUp: () {
      when(() => useCase(props: any(named: 'props')))
          .thenAnswer((_) async =>
          const Right(unit)
      );
    },
    build: () => sut,
    act: (sut) => sut.updateTask(props: updateTaskProps),
    expect: () =>[
      const TaskDetailsState.updated()
    ],);


  blocTest<TaskDetailsCubit, TaskDetailsState>(
    'should emit error message ',
    setUp: () {
      when(() => useCase(props: any(named: 'props')))
          .thenAnswer((_) async =>
      const Left(ServerFailure(message: 'error message', code: ''))
      );
    },
    build: () => sut,
    act: (sut) => sut.updateTask(props: updateTaskProps),
    expect: () => [
      const TaskDetailsState.failed(message: 'error message')
    ],);


}
