// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TreeModel _$$_TreeModelFromJson(Map<String, dynamic> json) => _$_TreeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      treeList: (json['treeList'] as List<dynamic>)
          .map((e) => TreeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_TreeModelToJson(_$_TreeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'treeList': instance.treeList,
    };
