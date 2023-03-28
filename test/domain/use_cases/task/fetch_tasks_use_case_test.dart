import 'package:dartz/dartz.dart';
import 'package:dartz_test/dartz_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/domain/use_cases/task/fetch_tasks_use_case.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';
import 'package:stg_frontend/infra/repositories/task_repository.dart';

import '../../../external/remote_datasource/fakes/task_fake.dart';
import '../../../external/remote_datasource/fakes/task_props_fake.dart';

class TaskRepositoryMock extends Mock implements TaskRepository {}

void main() {
  final repository = TaskRepositoryMock();

  late FetchTasksUseCase sut;

  setUp(() {
    sut = FetchTasksUseCase(repository);
    registerFallbackValue(FetchTasksPropsFake());
  });

  final fetchTasksProps = FetchTasksProps('id');

  test('should return right', () async {
    when(() => repository.fetchTasks(props: any(named: 'props')))
        .thenAnswer((_) async =>  Right(taskModelList));

    final result = await sut.call(props: fetchTasksProps);

    expect(result, isRight);
    expect(result, isRightThat(taskModelList));
    expect(result.fold(id, id), isA<List<TaskModel>>());
  });

  test('should return left with a failure', () async {
    when(() => repository.fetchTasks(props: any(named: 'props'))).thenAnswer(
      (_) async => const Left(
        ServerFailure(message: '', code: ''),
      ),
    );

    final result = await sut.call(props: fetchTasksProps);

    expect(result.fold(id, id), isA<ServerFailure>());
    expect(result, isLeft);
  });
}
