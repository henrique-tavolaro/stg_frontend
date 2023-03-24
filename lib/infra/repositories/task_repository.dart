

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/domain/i_repositories/i_task_repository.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';

@Injectable(as: ITaskRepository)
class TaskRepository implements ITaskRepository{

  final ITaskDatasource datasource;

  TaskRepository(this.datasource);

  @override
  Future<Either<Failure, TaskModel>> createTask({required CreateTaskProps props})async  {
    print('props rep ${props}');
    try {
      return right( await datasource.createTask(props: props));
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask({required DeleteTaskProps props}) async {
    try {
      return right( await datasource.deleteTask(props: props));
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> fetchTask({required FetchTaskProps props}) async {
    try {
      return right( await datasource.fetchTask(props: props));
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTask({required UpdateTaskProps props}) async {
    try {
      return right( await datasource.updateTask(props: props));
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, List<TaskModel>>> fetchTasks() async {
    try {
      return right( await datasource.fetchTasks());
    } on ServerException catch (e) {
    return left(ServerFailure(message: e.message, code: e.code));
    }
  }
}