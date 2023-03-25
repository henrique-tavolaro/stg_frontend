import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/domain/i_repositories/i_department_repository.dart';
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart';
import 'package:stg_frontend/infra/models/department/department_model.dart';

@Injectable(as: IDepartmentRepository)
class DepartmentRepository implements IDepartmentRepository {

  final IDepartmentDatasource datasource;

  DepartmentRepository(this.datasource);

  @override
  Future<Either<Failure, DepartmentModel>> createDepartment({required CreateDepartmentProps props}) async {
    try {
      return right( await datasource.createDepartment(props: props));
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteDepartment({required DeleteDepartmentProps props})async  {
    try {
      return right( await datasource.deleteDepartment(props: props));
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, DepartmentModel>> fetchDepartment({required FetchDepartmentProps props})async  {
    try {
      return right( await datasource.fetchDepartment(props: props));
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, List<DepartmentModel>>> fetchDepartments() async {
    try {
      return right( await datasource.fetchDepartments());
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message, code: e.code));
    }
  }
}