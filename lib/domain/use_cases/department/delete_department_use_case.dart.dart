

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/core/use_case/use_case.dart';
import 'package:stg_frontend/domain/i_repositories/i_department_repository.dart';
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart';

@injectable
class DeleteDepartmentUseCase implements UseCase<Unit, DeleteDepartmentProps> {

  final IDepartmentRepository repository;

  DeleteDepartmentUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call({required DeleteDepartmentProps props}) {
    return repository.deleteDepartment(props: props);
  }

}