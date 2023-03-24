import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:stg_frontend/core/constants/network.dart';

import 'i_client.dart';
import 'interceptor.dart';

@Singleton(as: IHttpClient)
class HttpClient extends IHttpClient {
  final Dio dio = Dio(
      BaseOptions(
          baseUrl: BASEURL,
))..interceptors.addAll([
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ),
    CustomInterceptor()
  ]);

  @override
  Future<HttpResponse<T>> get<T>({required HttpGetParams params}) async {
    final result = await dio.get(
      params.path,
      queryParameters: params.queryParameters,
    );

    return HttpResponse(
      statusCode: result.statusCode!,
      data: result.data,
      headers: result.headers.map,
    );
  }

  @override
  Future<HttpResponse<T>> delete<T>({required HttpDeleteParams params}) async {
    final result = await dio.delete(
      params.path,
      data: params.data,
      queryParameters: params.queryParameters,
    );

    return HttpResponse(
      statusCode: result.statusCode!,
      data: result.data,
      headers: result.headers.map,
    );
  }

  @override
  Future<HttpResponse<T>> put<T>({required HttpPutParams params}) async {
    final result = await dio.put(
      params.path,
      data: params.data,
      queryParameters: params.queryParameters,
    );

    return HttpResponse(
      statusCode: result.statusCode!,
      data: result.data,
      headers: result.headers.map,
    );
  }

  @override
  Future<HttpResponse<T>> post<T>({required HttpPostParams params}) async {
    final result = await dio.post(
      params.path,
      data: params.data,
      queryParameters: params.queryParameters,
    );

    return HttpResponse(
      statusCode: result.statusCode!,
      data: result.data,
      headers: result.headers.map,
    );
  }
}
