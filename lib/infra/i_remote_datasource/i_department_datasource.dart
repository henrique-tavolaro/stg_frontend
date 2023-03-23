
import 'package:dartz/dartz.dart';
import 'package:stg_frontend/infra/models/department/department_model.dart';

abstract class IDepartmentDatasource {
  Future<Unit> createDepartment({required CreateDepartmentProps props});
  Future<DepartmentModel> fetchDepartment({required FetchDepartmentProps props});
  Future<List<DepartmentModel>> fetchDepartments();
  Future<Unit> deleteDepartment({required DeleteDepartmentProps props});
}

class DeleteDepartmentProps {
  final String id;

  DeleteDepartmentProps(this.id);

}

class FetchDepartmentProps {
  final String id;

  FetchDepartmentProps(this.id);
}

class CreateDepartmentProps {
  final String name;

  CreateDepartmentProps(this.name);
}