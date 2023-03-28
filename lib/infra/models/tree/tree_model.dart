import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stg_frontend/domain/entities/tree_entity.dart';

part 'tree_model.freezed.dart';
part 'tree_model.g.dart';

@freezed
class TreeModel extends TreeEntity with _$TreeModel {
  factory TreeModel({
    required String id,
    required String name,
    required List<TreeModel> treeList,
  }) = _TreeModel;

  factory TreeModel.fromJson(Map<String, dynamic> json) => _$TreeModelFromJson(json);
}