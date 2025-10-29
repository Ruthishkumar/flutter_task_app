import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_task_app/view/api_clients/api_endpoints.dart';

class ApiInstance {
  final Dio dio;

  ApiInstance()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 5000),
        ),
      ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          log('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
          return handler.next(response); // continue
        },
        onError: (DioException e, handler) {
          log('ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}');
          return handler.next(e); // continue
        },
      ),
    );
  }
}
