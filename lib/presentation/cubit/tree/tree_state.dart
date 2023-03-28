part of 'tree_cubit.dart';

@freezed
class TreeState with _$TreeState {
  const factory TreeState.initial() = _Initial;

  const factory TreeState.loading() = _Loading;

  const factory TreeState.loaded({required List<TreeModel> treeList}) = _Loaded;

  const factory TreeState.failed(String message) = _Failed;
}