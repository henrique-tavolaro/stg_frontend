import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/domain/use_cases/task/fetch_tree_use_case.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/tree/tree_model.dart';

part 'tree_state.dart';

part 'tree_cubit.freezed.dart';

@injectable
class TreeCubit extends Cubit<TreeState> {
  final FetchTreeUseCase useCase;

  TreeCubit(this.useCase) : super(const TreeState.initial());

  Future<void> fetchTree({required FetchTreeByDepartmentProps props}) async {
    emit(const TreeState.loading());

    final inputEither = await useCase(props: props);

    inputEither.fold(
      (l) => emit(TreeState.failed(l.message)),
      (r) => emit(TreeState.loaded(treeList: r)),
    );
  }
}
