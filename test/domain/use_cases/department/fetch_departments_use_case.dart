import 'package:dartz/dartz.dart';
import 'package:dartz_test/dartz_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/core/use_case/use_case.dart';
import 'package:stg_frontend/domain/use_cases/department/fetch_departments_use_case.dart';
import 'package:stg_frontend/infra/models/department/department_model.dart';
import 'package:stg_frontend/infra/repositories/department_repository.dart';

import '../../../external/remote_datasource/fakes/department_fake.dart';

class DepartmentRepositoryMock extends Mock implements DepartmentRepository {}

void main() {
  final repository = DepartmentRepositoryMock();

  late FetchDepartmentsUseCase sut;

  setUp(() {
    sut = FetchDepartmentsUseCase(repository);
  });

  test('should return right', () async {
    when(() => repository.fetchDepartments())
        .thenAnswer((_) async => Right(departmentModelList));

    final result = await sut.call(props: const NoProps());

    expect(result, isRight);
    expect(result, isRightThat(departmentModelList));
    expect(result.fold(id, id), isA<List<DepartmentModel>>());
  });

  test('should return left with a failure', () async {
    when(() => repository.fetchDepartments())
        .thenAnswer(
          (_) async => const Left(
        ServerFailure(message: '', code: ''),
      ),
    );

    final result = await sut.call(props: const NoProps());

    expect(result.fold(id, id), isA<ServerFailure>());
    expect(result, isLeft);
  });
}
