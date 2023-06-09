import 'package:stg_frontend/infra/models/department/department_model.dart';

final departmentJson = {
  "_id": "fakeId",
  "name": "name",
  "createdAt": "2022-03-21T10:00:00Z",
  "deletedAt": null
};

final departmentModel = DepartmentModel.fromJson(departmentJson);

final departmentListJson = [
  {
    "_id": "fakeId",
    "name": "name",
    "createdAt": "2022-03-21T10:00:00Z",
    "deletedAt": null
  },
  {
    "_id": "fakeId",
    "name": "name",
    "createdAt": "2022-03-21T10:00:00Z",
    "deletedAt": null
  },
  {
    "_id": "fakeId",
    "name": "name",
    "createdAt": "2022-03-21T10:00:00Z",
    "deletedAt": null
  }
];

final departmentModelList = departmentListJson.map<DepartmentModel>((department) {
  final item = DepartmentModel.fromJson(department);
  return item;
}).toList();