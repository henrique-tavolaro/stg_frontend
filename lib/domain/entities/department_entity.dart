class DepartmentEntity {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime? deletedAt;

  DepartmentEntity(
    this.id,
    this.name,
    this.createdAt,
    this.deletedAt,
  );
}
