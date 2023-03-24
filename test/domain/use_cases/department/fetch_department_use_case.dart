import 'package:dartz/dartz.dart';
import 'package:dartz_test/dartz_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/domain/use_cases/department/fetch_department_use_case.dart';
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart';
import 'package:stg_frontend/infra/models/department/department_model.dart';
import 'package:stg_frontend/infra/repositories/department_repository.dart';

import '../../../external/remote_datasource/fakes/department_fake.dart';
import '../../../external/remote_datasource/fakes/department_props_fake.dart';

class DepartmentRepositoryMock extends Mock implements DepartmentRepository {}

void main() {
  final repository = DepartmentRepositoryMock();

  late FetchDepartmentUseCase sut;

  setUp(() {
    sut = FetchDepartmentUseCase(repository);
    registerFallbackValue(FetchDepartmentPropsFake());
  });

  test('should return right', () async {
    when(() => repository.fetchDepartment(props: any(named: 'props')))
        .thenAnswer((_) async => Right(departmentModel));

    final result = await sut.call(props: FetchDepartmentProps('id'));

    expect(result, isRight);
    expect(result, isRightThat(departmentModel));
    expect(result.fold(id, id), isA<DepartmentModel>());
  });

  test('should return left with a failure', () async {
    when(() => repository.fetchDepartment(props: any(named: 'props')))
        .thenAnswer(
          (_) async => const Left(
        ServerFailure(message: '', code: ''),
      ),
    );

    final result = await sut.call(props: FetchDepartmentProps('id'));

    expect(result.fold(id, id), isA<ServerFailure>());
    expect(result, isLeft);
  });
}
