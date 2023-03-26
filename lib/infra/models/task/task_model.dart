import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stg_frontend/domain/entities/task_entity.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
class TaskModel extends TaskEntity with _$TaskModel {
  factory TaskModel({
    @JsonKey(name: '_id') required String id,
    String? previusId,
    String? fatherId,
    required String name,
    required String department,
    required List<String> assignedTo,
    String? documentation,
    required List<String> systems,
    required List<String> tasks,
    required DateTime createdAt,
    DateTime? deletedAt,
}) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
}