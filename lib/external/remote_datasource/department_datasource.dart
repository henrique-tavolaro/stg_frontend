import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:stg_frontend/core/contants/app_texts.dart';
import 'package:stg_frontend/core/error/failure.dart';
import 'package:stg_frontend/core/network/i_client.dart';
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart';
import 'package:stg_frontend/infra/models/department/department_model.dart';

@Injectable(as: IDepartmentDatasource)
class DepartmentDatasource implements IDepartmentDatasource {
  final IHttpClient client;

  DepartmentDatasource(this.client);

  @override
  Future<Unit> createDepartment({required CreateDepartmentProps props}) async {
    try {
      final response = await client.post(
        params: HttpPostParams(
          path: '/department',
          data: {props},
        ),
      );

      if (response.statusCode == 201) {
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
        message: e.message,
        code: e.response?.statusCode?.toString() ?? '',
      );
    }
  }

  @override
  Future<Unit> deleteDepartment({required DeleteDepartmentProps props}) async {
    try {
      final response = await client.delete(
        params: HttpDeleteParams(
          path: '/department',
          data: {props},
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
        message: e.message,
        code: e.response?.statusCode?.toString() ?? '',
      );
    }
  }

  @override
  Future<DepartmentModel> fetchDepartment(
      {required FetchDepartmentProps props}) async {
    try {
      final response = await client.get(
        params: HttpGetParams(
          path: '/department'
        ),
      );

      if (response.statusCode == 200) {
        return DepartmentModel.fromJson(response.data);
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
        message: e.message,
        code: e.response?.statusCode?.toString() ?? '',
      );
    }
  }

  @override
  Future<List<DepartmentModel>> fetchDepartments() async {
    try {
      var departments = <DepartmentModel>[];
      final response = await client.get(
        params: HttpGetParams(
            path: '/departments'
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data as List;
        if(data.isNotEmpty) {
          departments = data.map<DepartmentModel>((department) {
            final item = DepartmentModel.fromJson(department);
            return item;
          }).toList();
        }
        return departments;
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
        message: e.message,
        code: e.response?.statusCode?.toString() ?? '',
      );
    }
  }
}
