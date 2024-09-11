import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioUtils {
  static Dio initDio(String baseUrl) {
    const isLogAllowed = !kReleaseMode;
    final dioInstance = Dio(
      BaseOptions(baseUrl: baseUrl),
    );
    if (isLogAllowed) {
      dioInstance.interceptors.add(loggerInterceptor());
    }

    return dioInstance;
  }

  static Interceptor loggerInterceptor() {
    const isLogAllowed = !kReleaseMode;
    return PrettyDioLogger(
      request: isLogAllowed,
      // requestHeader: isLogAllowed,
      responseBody: isLogAllowed,
      requestBody: isLogAllowed,
      // responseHeader: isLogAllowed,
      logPrint: (log) {
        developer.log(
          '$log',
        );
      },
    );
  }
}
