import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/core/use_case/use_case.dart';
import 'package:stg_frontend/domain/i_repositories/i_task_repository.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/tree/tree_model.dart';

@injectable
class FetchTreeUseCase implements UseCase<List<TreeModel>, FetchTreeByDepartmentProps> {

  final ITaskRepository repository;

  FetchTreeUseCase(this.repository);

  @override
  Future<Either<Failure, List<TreeModel>>> call({required FetchTreeByDepartmentProps props}) {
    return repository.fetchTreeByDepartment(props: props);
  }
}