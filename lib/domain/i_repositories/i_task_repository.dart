

import 'package:dartz/dartz.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/infra/models/tree/tree_model.dart';

import '../../infra/i_remote_datasource/I_task_datasource.dart';
import '../../infra/models/task/task_model.dart';

abstract class ITaskRepository {
  Future<Either<Failure, TaskModel>> createTask({required CreateTaskProps props});

  Future<Either<Failure, Unit>> deleteTask({required DeleteTaskProps props});

  Future<Either<Failure, TaskModel>> fetchTask({required FetchTaskProps props});

  Future<Either<Failure, Unit>> updateTask({required UpdateTaskProps props});

  Future<Either<Failure, List<TaskModel>>> fetchTasks({required FetchTasksProps props});

  Future<Either<Failure, List<TaskModel>>> fetchTasksByDepartment({required FetchTasksByDepartmentProps props});

  Future<Either<Failure, List<TreeModel>>> fetchTreeByDepartment({required FetchTreeByDepartmentProps props});
}