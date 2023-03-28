

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/domain/use_cases/task/fetch_tree_use_case.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/presentation/cubit/tree/tree_cubit.dart';

import '../../external/remote_datasource/fakes/task_props_fake.dart';
import '../../external/remote_datasource/fakes/tree_fake.dart';

class FetchTreeUseCaseMock extends Mock implements FetchTreeUseCase {}

void main() {
  final useCase = FetchTreeUseCaseMock();
  late TreeCubit sut;

  setUp(() {
    sut = TreeCubit(useCase);
    registerFallbackValue(FetchTreePropsFake());
  });

  test('should emit initial state', () async {
    expect(sut.state, const TreeState.initial()
    );
  });

  final fetchTreeProps = FetchTreeByDepartmentProps('name');

  blocTest<TreeCubit, TreeState>(
    'should emit tree ',
    setUp: () {
      when(() => useCase(props: any(named: 'props')))
          .thenAnswer((_) async =>
          Right(treeListFake)
      );
    },
    build: () => sut,
    act: (sut) => sut.fetchTree(props: fetchTreeProps),
    expect: () =>
    [
      const TreeState.loading(),
      TreeState.loaded(treeList: treeListFake)
    ],);


  blocTest<TreeCubit, TreeState>(
    'should emit error message ',
    setUp: () {
      when(() => useCase(props: any(named: 'props')))
          .thenAnswer((_) async =>
      const Left(ServerFailure(message: 'error message', code: ''))
      );
    },
    build: () => sut,
    act: (sut) => sut.fetchTree(props: fetchTreeProps),
    expect: () =>
    [
      const TreeState.loading(),
      const TreeState.failed('error message')
    ],);

}
