import 'package:stg_frontend/core/enums/task_status.dart';

class TaskEntity {
  final String id;
  final String? previusId;
  final String? fatherId;
  final String name;
  final String department;
  final String? description;
  final List<String> assignedTo;
  final String? documentation;
  final List<String> systems;
  final List<String> tasks;
  final TaskStatus status;
  final DateTime createdAt;
  final DateTime? deletedAt;

  TaskEntity(
    this.id,
    this.previusId,
    this.fatherId,
    this.name,
    this.department,
    this.description,
    this.assignedTo,
    this.documentation,
    this.systems,
    this.tasks,
    this.createdAt,
    this.deletedAt,
    this.status,
  );
}
