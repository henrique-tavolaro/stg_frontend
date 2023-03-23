import 'package:dartz/dartz.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart';
import 'package:stg_frontend/infra/models/department/department_model.dart';

abstract class IDepartmentRepository {
  Future<Either<Failure, Unit>> createDepartment({required CreateDepartmentProps props});
  Future<Either<Failure, DepartmentModel>> fetchDepartment({required FetchDepartmentProps props});
  Future<Either<Failure, List<DepartmentModel>>> fetchDepartments();
  Future<Either<Failure, Unit>> deleteDepartment({required DeleteDepartmentProps props});
}