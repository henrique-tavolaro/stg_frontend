import 'package:dartz/dartz.dart';
import 'package:dartz_test/dartz_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/domain/use_cases/task/create_task_use_case.dart';
import 'package:stg_frontend/domain/use_cases/task/delete_task_use_case.dart.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/repositories/task_repository.dart';

import '../../../external/remote_datasource/fakes/task_props_fake.dart';

class TaskRepositoryMock extends Mock implements TaskRepository {}

void main() {
  final repository = TaskRepositoryMock();

  late DeleteTaskUseCase sut;

  setUp(() {
    sut = DeleteTaskUseCase(repository);
    registerFallbackValue(DeleteTaskPropsFake());
  });

  test('should return right', () async {
    when(() => repository.deleteTask(props: any(named: 'props')))
        .thenAnswer((_) async => const Right(unit));

    final result = await sut.call(props: DeleteTaskProps('id', null, null));

    expect(result, isRight);
    expect(result, isRightThat(unit));
    expect(result.fold(id, id), isA<Unit>());
  });

  test('should return left with a failure', () async {
    when(() => repository.deleteTask(props: any(named: 'props')))
        .thenAnswer(
      (_) async => const Left(
        ServerFailure(message: '', code: ''),
      ),
    );

    final result = await sut.call(props: DeleteTaskProps('id', null, null));

    expect(result.fold(id, id), isA<ServerFailure>());
    expect(result, isLeft);
  });
}
