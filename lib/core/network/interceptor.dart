

import 'package:dio/dio.dart';

class CustomInterceptor extends InterceptorsWrapper {

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {

    super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
      Response<dynamic> response,
      ResponseInterceptorHandler handler,
      ) async {

    super.onResponse(response, handler);
  }
}