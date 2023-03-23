import 'package:stg_frontend/infra/models/task/task_model.dart';

final taskJson = {
"id": "123",
"previusId": "122",
"fatherId": "121",
"name": "Implementar login com autenticação JWT",
"department": "Desenvolvimento",
"description": "Criar tela de login e implementar autenticação JWT para garantir a segurança da aplicação.",
"assignedTo": ["João", "Maria"],
"documentation": "https://example.com/documentacao",
"systems": ["Sistema de autenticação"],
"tasks": ["Criar backend", "Criar frontend"],
"status": "PENDING",
"createdAt": "2022-03-21T10:00:00Z",
"deletedAt": null
};

final taskModel = TaskModel.fromJson(taskJson);