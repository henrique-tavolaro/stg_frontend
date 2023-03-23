

import 'package:dartz/dartz.dart';
import 'package:stg_frontend/core/error/failure.dart';

import '../../infra/i_remote_datasource/I_task_datasource.dart';
import '../../infra/models/task/task_model.dart';

abstract class ITaskRepository {
  Future<Either<Failure, Unit>> createTask({required CreateTaskProps props});

  Future<Either<Failure, Unit>> deleteTask({required DeleteTaskProps props});

  Future<Either<Failure, TaskModel>> fetchTask({required FetchTaskProps props});

  Future<Either<Failure, Unit>> updateTask({required UpdateTaskProps props});
}