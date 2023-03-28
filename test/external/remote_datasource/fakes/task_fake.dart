import 'package:stg_frontend/infra/models/task/task_model.dart';

final taskJson = {
  "_id": "id",
  "previusId": "122",
  "fatherId": "121",
  "name": "Implementar login com autenticação JWT",
  "department": "Desenvolvimento",
  "assignedTo": ["João", "Maria"],
  "documentation": "https://example.com/documentacao",
  "systems": ["Sistema de autenticação"],
  "tasks": ["Criar backend", "Criar frontend"],
  "createdAt": "2022-03-21T10:00:00Z",
  "deletedAt": null
};

final taskModel = TaskModel.fromJson(taskJson);

final taskModelListJson = [
  {
    "_id": "123",
    "previusId": "122",
    "fatherId": "121",
    "name": "Implementar login com autenticação JWT",
    "department": "Desenvolvimento",
    "assignedTo": ["João", "Maria"],
    "documentation": "https://example.com/documentacao",
    "systems": ["Sistema de autenticação"],
    "tasks": ["Criar backend", "Criar frontend"],
     "createdAt": "2022-03-21T10:00:00Z",
    "deletedAt": null
  },
  {
    "_id": "123",
    "previusId": "122",
    "fatherId": "121",
    "name": "Implementar login com autenticação JWT",
    "department": "Desenvolvimento",
    "assignedTo": ["João", "Maria"],
    "documentation": "https://example.com/documentacao",
    "systems": ["Sistema de autenticação"],
    "tasks": ["Criar backend", "Criar frontend"],
    "createdAt": "2022-03-21T10:00:00Z",
    "deletedAt": null
  },
  {
    "_id": "123",
    "previusId": "122",
    "fatherId": "121",
    "name": "Implementar login com autenticação JWT",
    "department": "Desenvolvimento",
    "assignedTo": ["João", "Maria"],
    "documentation": "https://example.com/documentacao",
    "systems": ["Sistema de autenticação"],
    "tasks": ["Criar backend", "Criar frontend"], "createdAt": "2022-03-21T10:00:00Z",
    "deletedAt": null
  }
];

final taskModelList = taskModelListJson.map<TaskModel>((task) {
  final item = TaskModel.fromJson(task);
  return item;
}).toList();
