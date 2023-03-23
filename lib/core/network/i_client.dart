import 'package:injectable/injectable.dart';

abstract class IHttpClient {
  Future<HttpResponse<T>> get<T>({required HttpGetParams params});

  Future<HttpResponse<T>> post<T>({required HttpPostParams params});

  Future<HttpResponse<T>> put<T>({required HttpPutParams params});

  Future<HttpResponse<T>> delete<T>({required HttpDeleteParams params});
}

class HttpResponse<T> {
  final int statusCode;
  final dynamic data;
  final  Map<String, dynamic>? headers;

  HttpResponse({
    required this.headers,
    required this.statusCode,
    required this.data,
  });
}

class HttpGetParams {
  final String path;
  final Map<String, dynamic>? queryParameters;
  final String? headers;

  HttpGetParams({
    required this.path,
    this.queryParameters,
    this.headers,
  });
}

class HttpPostParams {
  final String path;
  final dynamic data;
  final Map<String, dynamic>? queryParameters;
  final String? headers;

  HttpPostParams({
    required this.path,
    required this.data,
    this.queryParameters,
    this.headers,
  });
}

class HttpPutParams {
  final String path;
  final dynamic data;
  final Map<String, dynamic>? queryParameters;
  final String? headers;

  HttpPutParams({
    required this.path,
    required this.data,
    this.queryParameters,
    this.headers,
  });
}

class HttpDeleteParams {
  final String path;
  final dynamic data;
  final Map<String, dynamic>? queryParameters;
  final String? headers;

  HttpDeleteParams({
    required this.path,
    required this.data,
    this.queryParameters,
    this.headers,
  });
}
