// Dart imports:
import 'dart:async';
import 'dart:io';

// Package imports:
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../config/const.dart';
import '../config/enums.dart';

class DioConfig {
  // Static Dio created to directly access Dio client
  static Dio getDio({
    dynamic data,
    bool hasAuth = true,
    bool hasBody = true,
  }) {
    var dio = Dio();
    Map<String, String> requestHeaders;

    // Passing Headers
    requestHeaders = {
      'Content-Type': 'application/json',
      // 'Accept': 'application/json;charset=UTF-8',
      if (hasAuth) 'Authorization': 'Bearer ${Const.appBearerToken}',
      // 'User-Agent': Platform.isAndroid ? 'Android' : 'iOS',
    };

    BaseOptions options;
    // Adding Additional Options
    options = BaseOptions(
      receiveTimeout: const Duration(seconds: 5),
      connectTimeout: const Duration(seconds: 5),
      headers: requestHeaders,
    );

    dio = Dio(options);

    dio.interceptors.addAll([
      InterceptorsWrapper(onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        if (hasBody) options.data = data;
        return handler.next(options);
      }),
      // DioFirebasePerformanceInterceptor(),
    ]);

    return dio;
  }

  Future<Response> dioServe({
    dynamic data,
    bool hasAuth = true,
    bool hasBody = true,
    required String url,
    HttpMethod httpMethod = HttpMethod.get,
  }) async {
    Response response;
    const timeoutDuration = Duration(seconds: 200);
    final dio = getDio(
      data: data,
      hasAuth: hasAuth,
      hasBody: hasBody,
    );
    try {
      response = await retry(
        () async {
          Response inResponse;
          switch (httpMethod) {
            case HttpMethod.get:
              inResponse = await dio.get(url).timeout(timeoutDuration);
              break;
            case HttpMethod.post:
              inResponse = await dio.post(url).timeout(timeoutDuration);
              break;
            case HttpMethod.put:
              inResponse = await dio.put(url).timeout(timeoutDuration);
              break;
            case HttpMethod.delete:
              inResponse = await dio.delete(url).timeout(timeoutDuration);
              break;
            case HttpMethod.patch:
              inResponse = await dio.patch(url).timeout(timeoutDuration);
              break;
            default:
              inResponse = await dio.get(url).timeout(timeoutDuration);
              break;
          }

          return inResponse;
        },
        // Retry on SocketException or TimeoutException
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
      return response;
    } finally {
      dio.close();
    }
  }
}
