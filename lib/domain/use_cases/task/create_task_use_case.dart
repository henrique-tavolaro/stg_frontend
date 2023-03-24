import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/core/use_case/use_case.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/domain/i_repositories/i_task_repository.dart';

@injectable
class CreateTaskUseCase implements UseCase<Unit, CreateTaskProps> {

  final ITaskRepository repository;

  CreateTaskUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call({required CreateTaskProps props}) {
    return repository.createTask(props: props);
  }

}