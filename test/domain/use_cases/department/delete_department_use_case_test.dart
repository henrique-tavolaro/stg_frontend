import 'package:dartz/dartz.dart';
import 'package:dartz_test/dartz_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/domain/use_cases/department/delete_department_use_case.dart.dart';
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart';
import 'package:stg_frontend/infra/repositories/department_repository.dart';

import '../../../external/remote_datasource/fakes/department_props_fake.dart';

class DepartmentRepositoryMock extends Mock implements DepartmentRepository {}

void main() {
  final repository = DepartmentRepositoryMock();

  late DeleteDepartmentUseCase sut;

  setUp(() {
    sut = DeleteDepartmentUseCase(repository);
    registerFallbackValue(DeleteDepartmentPropsFake());
  });

  test('should return right', () async {
    when(() => repository.deleteDepartment(props: any(named: 'props')))
        .thenAnswer((_) async => const Right(unit));

    final result = await sut.call(props: DeleteDepartmentProps('id'));

    expect(result, isRight);
    expect(result, isRightThat(unit));
    expect(result.fold(id, id), isA<Unit>());
  });

  test('should return left with a failure', () async {
    when(() => repository.deleteDepartment(props: any(named: 'props')))
        .thenAnswer(
      (_) async => const Left(
        ServerFailure(message: '', code: ''),
      ),
    );

    final result = await sut.call(props: DeleteDepartmentProps('id'));

    expect(result.fold(id, id), isA<ServerFailure>());
    expect(result, isLeft);
  });
}
