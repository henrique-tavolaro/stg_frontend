

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/core/use_case/use_case.dart';
import 'package:stg_frontend/domain/i_repositories/i_department_repository.dart';
import 'package:stg_frontend/infra/models/department/department_model.dart';

@injectable
class FetchDepartmentsUseCase implements UseCase<List<DepartmentModel>, NoProps> {

  final IDepartmentRepository repository;

  FetchDepartmentsUseCase(this.repository);

  @override
  Future<Either<Failure, List<DepartmentModel>>> call({required NoProps props}) {
    return repository.fetchDepartments();
  }

}