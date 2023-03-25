import 'package:dartz/dartz.dart';
import 'package:stg_frontend/core/enums/task_status.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';

abstract class ITaskDatasource {
  Future<TaskModel> createTask({required CreateTaskProps props});

  Future<Unit> deleteTask({required DeleteTaskProps props});

  Future<TaskModel> fetchTask({required FetchTaskProps props});

  Future<Unit> updateTask({required UpdateTaskProps props});

  Future<List<TaskModel>> fetchTasks();

  Future<List<TaskModel>> fetchTasksByDepartment({required FetchTasksByDepartmentProps props});
}

class FetchTasksByDepartmentProps {
  final String name;

  FetchTasksByDepartmentProps(this.name);
}

class UpdateTaskProps {
  final String id;
  final String? previusId;
  final String? fatherId;
  final String? name;
  final String? description;
  final List<String> assignedTo;
  final String? documentation;
  final List<String> systems;
  final TaskStatus? status;

  UpdateTaskProps(
      this.id,
      this.previusId,
      this.fatherId,
      this.name,
      this.description,
      this.assignedTo,
      this.documentation,
      this.systems,
      this.status);
}

class FetchTaskProps {
  final String id;
  final String? previusId;
  final String? fatherId;

  FetchTaskProps(this.id, this.previusId, this.fatherId);
}

class DeleteTaskProps {
  final String id;
  final String? previusId;
  final String? fatherId;

  DeleteTaskProps(this.id, this.previusId, this.fatherId);
}

class CreateTaskProps {
  final String name;
  final String department;
  final String? previusId;
  final String? fatherId;

  CreateTaskProps(
    this.name,
      this.department,
    this.previusId,
    this.fatherId,

  );
}
