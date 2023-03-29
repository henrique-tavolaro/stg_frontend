import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/core/constants/app_texts.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/core/network/i_client.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/task/task_model.dart';
import 'package:stg_frontend/infra/models/tree/tree_model.dart';

@Injectable(as: ITaskDatasource)
class TaskDatasource implements ITaskDatasource {
  final IHttpClient client;

  TaskDatasource(this.client);

  @override
  Future<TaskModel> createTask({required CreateTaskProps props}) async {
    try {
      final response = await client.post(
        params: HttpPostParams(path: '/task', data: {
          "name": props.name,
          'department': props.department,
          'fatherId': props.fatherId,
          'previusId': props.previusId
        }),
      );

      if (response.statusCode == 201) {
        return TaskModel.fromJson(response.data);
      }

      throw ServerException(
        message: AppTexts.internalError,
        code: response.statusCode.toString(),
      );
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const ServerException.noConnection();
      }

      throw ServerException(
        message: AppTexts.internalError,
        code: e.response?.statusCode?.toString() ?? '',
      );
    }
  }

  @override
  Future<Unit> deleteTask({required DeleteTaskProps props}) async {
    try {
      final response = await client.delete(
        params: HttpDeleteParams(
          path: '/task',
          data: {
            "id": props.id,
            "fatherId": props.fatherId,
            "previusId": props.previusId
          },
        ),
      );

      if (response.statusCode == 200) {
        return unit;
      }

      throw ServerException(
        message: AppTexts.internalError,
        code: response.statusCode.toString(),
      );
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const ServerException.noConnection();
      }

      throw ServerException(
        message: AppTexts.internalError,
        code: e.response?.statusCode?.toString() ?? '',
      );
    }
  }

  @override
  Future<TaskModel> fetchTask({required FetchTaskProps props}) async {
    try {
      final response = await client.get(
        params: HttpGetParams(path: '/task'),
      );

      if (response.statusCode == 200) {
        return TaskModel.fromJson(response.data);
      }

      throw ServerException(
        message: AppTexts.internalError,
        code: response.statusCode.toString(),
      );
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const ServerException.noConnection();
      }

      throw ServerException(
        message: AppTexts.internalError,
        code: e.response?.statusCode?.toString() ?? '',
      );
    }
  }

  @override
  Future<Unit> updateTask({required UpdateTaskProps props}) async {
    try {
      final response = await client.put(
        params: HttpPutParams(
          path: '/task',
          data: {
            "id": props.id,
            "previusId": props.previusId,
            "fatherId": props.fatherId,
            "name": props.name,
            "assignedTo": props.assignedTo,
            "documentation": props.documentation,
            "systems": props.systems,
          },
        ),
      );

      if (response.statusCode == 200) {
        return unit;
      }

      throw ServerException(
        message: AppTexts.internalError,
        code: response.statusCode.toString(),
      );
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const ServerException.noConnection();
      }

      throw ServerException(
        message: AppTexts.internalError,
        code: e.response?.statusCode?.toString() ?? '',
      );
    }
  }

  @override
  Future<List<TaskModel>> fetchTasks({required FetchTasksProps props}) async {
    try {
      var tasks = <TaskModel>[];
      final response = await client.get(
        params: HttpGetParams(path: '/tasks/${props.id}'),
      );

      if (response.statusCode == 200) {
        final data = response.data as List;

        if (data.isNotEmpty) {
          tasks = data.map<TaskModel>((task) {
            final item = TaskModel.fromJson(task);
            return item;
          }).toList();
        }
        return tasks;
      }

      throw ServerException(
        message: AppTexts.internalError,
        code: response.statusCode.toString(),
      );
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const ServerException.noConnection();
      }

      throw ServerException(
        message: AppTexts.internalError,
        code: e.response?.statusCode?.toString() ?? '',
      );
    }
  }

  @override
  Future<List<TaskModel>> fetchTasksByDepartment(
      {required FetchTasksByDepartmentProps props}) async       {
    try {
      var tasks = <TaskModel>[];
      final response = await client.get(
        params: HttpGetParams(
          path: '/tasksdepartment/${props.name}',
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data as List;

        if (data.isNotEmpty) {
          tasks = data.map<TaskModel>((task) {
            final item = TaskModel.fromJson(task);
            return item;
          }).toList();
        }
        return tasks;
      }

      throw ServerException(
        message: AppTexts.internalError,
        code: response.statusCode.toString(),
      );
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const ServerException.noConnection();
      }

      throw ServerException(
        message: AppTexts.internalError,
        code: e.response?.statusCode?.toString() ?? '',
      );
    }
  }

  @override
  Future<List<TreeModel>> fetchTreeByDepartment(
      {required FetchTreeByDepartmentProps props}) async {
    try {
      var trees = <TreeModel>[];
      final response = await client.get(
        params: HttpGetParams(
          path: '/alltasksdepartment/${props.name}',
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data as List;

        if (data.isNotEmpty) {
          trees = data.map<TreeModel>((task) {
            final item = TreeModel.fromJson(task);
            return item;
          }).toList();
        }
        return trees;
      }

      throw ServerException(
        message: AppTexts.internalError,
        code: response.statusCode.toString(),
      );
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw const ServerException.noConnection();
      }

      throw ServerException(
        message: AppTexts.internalError,
        code: e.response?.statusCode?.toString() ?? '',
      );
    }
  }
}
