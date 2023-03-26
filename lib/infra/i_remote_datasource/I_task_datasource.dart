import 'package:dartz/dartz.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';

abstract class ITaskDatasource {
  Future<TaskModel> createTask({required CreateTaskProps props});

  Future<Unit> deleteTask({required DeleteTaskProps props});

  Future<TaskModel> fetchTask({required FetchTaskProps props});

  Future<Unit> updateTask({required UpdateTaskProps props});

  Future<List<TaskModel>> fetchTasks({required FetchTasksProps props});

  Future<List<TaskModel>> fetchTasksByDepartment({required FetchTasksByDepartmentProps props});
}

class FetchTasksProps {
  final String id;

  FetchTasksProps(this.id);
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
  final List<String> assignedTo;
  final String? documentation;
  final List<String> systems;

  UpdateTaskProps(
      this.id,
      this.previusId,
      this.fatherId,
      this.name,
      this.assignedTo,
      this.documentation,
      this.systems,
);
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
