import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stg_frontend/domain/entities/department_entity.dart';

part 'department_model.freezed.dart';
part 'department_model.g.dart';

@freezed
class DepartmentModel extends DepartmentEntity with _$DepartmentModel {
  const factory DepartmentModel({
    required String id,
    required String name,
    required DateTime createdAt,
    DateTime? deletedAt,
  }) = _DepartmentModel;

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentModelFromJson(json);
}
