import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/core/use_case/use_case.dart';
import 'package:stg_frontend/domain/i_repositories/i_task_repository.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';

@injectable
class DeleteTaskUseCase implements UseCase<Unit, DeleteTaskProps> {

  final ITaskRepository repository;

  DeleteTaskUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call({required DeleteTaskProps props}) {
    return repository.deleteTask(props: props);
  }

}