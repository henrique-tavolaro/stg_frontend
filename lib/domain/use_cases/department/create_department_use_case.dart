

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/core/use_case/use_case.dart';
import 'package:stg_frontend/domain/i_repositories/i_department_repository.dart';
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart';
import 'package:stg_frontend/infra/models/department/department_model.dart';

@injectable
class CreateDepartmentUseCase implements UseCase<DepartmentModel, CreateDepartmentProps> {

  final IDepartmentRepository repository;

  CreateDepartmentUseCase(this.repository);

  @override
  Future<Either<Failure, DepartmentModel>> call({required CreateDepartmentProps props}) {
    return repository.createDepartment(props: props);
  }

}