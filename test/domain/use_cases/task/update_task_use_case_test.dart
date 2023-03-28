import 'package:dartz/dartz.dart';
import 'package:dartz_test/dartz_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/domain/use_cases/task/update_task_use_case.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/repositories/task_repository.dart';

import '../../../external/remote_datasource/fakes/task_props_fake.dart';

class TaskRepositoryMock extends Mock implements TaskRepository {}

void main() {
  final repository = TaskRepositoryMock();

  late UpdateTaskUseCase sut;

  setUp(() {
    sut = UpdateTaskUseCase(repository);
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

  test('should return right', () async {
    when(() => repository.updateTask(props: any(named: 'props')))
        .thenAnswer((_) async => const Right(unit));

    final result = await sut.call(
        props: updateTaskProps);

    expect(result, isRight);
    expect(result, isRightThat(unit));
    expect(result.fold(id, id), isA<Unit>());
  });

  test('should return left with a failure', () async {
    when(() => repository.updateTask(props: any(named: 'props'))).thenAnswer(
      (_) async => const Left(
        ServerFailure(message: '', code: ''),
      ),
    );

    final result = await sut.call(props: updateTaskProps);

    expect(result.fold(id, id), isA<ServerFailure>());
    expect(result, isLeft);
  });
}
