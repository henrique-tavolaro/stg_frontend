

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/core/use_case/use_case.dart';
import 'package:stg_frontend/domain/i_repositories/i_task_repository.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';

@injectable
class FetchTasksByDepartmentUseCase implements UseCase<List<TaskModel>, FetchTasksByDepartmentProps> {

  final ITaskRepository repository;

  FetchTasksByDepartmentUseCase(this.repository);

  @override
  Future<Either<Failure, List<TaskModel>>> call({required FetchTasksByDepartmentProps props}) {
    return repository.fetchTasksByDepartment(props: props);
  }
}