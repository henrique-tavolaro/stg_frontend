import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/core/use_case/use_case.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/domain/i_repositories/i_task_repository.dart';

@injectable
class UpdateTaskUseCase implements UseCase<Unit, UpdateTaskProps> {

  final ITaskRepository repository;

  UpdateTaskUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call({required UpdateTaskProps props}) {
    return repository.updateTask(props: props);
  }

}