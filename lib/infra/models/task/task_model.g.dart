// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskModel _$$_TaskModelFromJson(Map<String, dynamic> json) => _$_TaskModel(
      id: json['_id'] as String,
      previusId: json['previusId'] as String?,
      fatherId: json['fatherId'] as String?,
      name: json['name'] as String,
      department: json['department'] as String,
      assignedTo: (json['assignedTo'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      documentation: json['documentation'] as String?,
      systems:
          (json['systems'] as List<dynamic>).map((e) => e as String).toList(),
      tasks: (json['tasks'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$$_TaskModelToJson(_$_TaskModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'previusId': instance.previusId,
      'fatherId': instance.fatherId,
      'name': instance.name,
      'department': instance.department,
      'assignedTo': instance.assignedTo,
      'documentation': instance.documentation,
      'systems': instance.systems,
      'tasks': instance.tasks,
      'createdAt': instance.createdAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };
