
class TaskEntity {
  final String _id;
  final String? previusId;
  final String? fatherId;
  final String name;
  final String department;
  final List<String> assignedTo;
  final String? documentation;
  final List<String> systems;
  final List<String> tasks;
  final DateTime createdAt;
  final DateTime? deletedAt;


  TaskEntity(
    this._id,
    this.previusId,
    this.fatherId,
    this.name,
    this.department,
    this.assignedTo,
    this.documentation,
    this.systems,
    this.tasks,
    this.createdAt,
    this.deletedAt,
  );
}
