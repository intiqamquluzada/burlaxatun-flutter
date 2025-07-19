import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart' show PrettyDioLogger;

import '../../../cubits/splash/splash_cubit.dart';
import '../../../utils/di/locator.dart';

class BaseNetwork {
  BaseNetwork._();

  static BaseNetwork? _instance;

  static BaseNetwork get instance => _instance ??= BaseNetwork._();

  Dio? _dio;

  /// Get
  Dio getDio({String? token}) {
    log('authorization token is this: $token');
    _dio ??= Dio()
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          compact: true,
        ),
      )
      ..interceptors.add(
        InterceptorsWrapper(
          onError: (DioException error, ErrorInterceptorHandler handler) {
            log('Dio Error: ${error.message}');
            // You can handle different error cases here
            if (error.response?.statusCode == 401) {
              // Handle unauthorized error (e.g., token expired)
              log('Unauthorized: ${error.response?.data}');
              log('ERROR WHILE SPLASHING');

              //? If the token is expired or unauthorized, delete the saved login token
              //? and redirect to the login page

              // locator<LoginTokenService>().deleteSaveByKey("login");

              // navigatorKey.currentContext?.go('/login');
              // navigatorKey.currentContext?.read<MainnCubit>().changeView(0);
              locator<SplashCubit>().refreshToken();
            } else if (error.response?.statusCode == 404) {
              // Handle not found error
              log('Not Found: ${error.response?.data}');
            }
            // Continue with the error
            return handler.next(error);
          },
        ),
      );

    if (token != null) {
      _dio!.options.headers['Authorization'] = 'Bearer $token';
    } else {
      _dio!.options.headers['Authorization'] = null;
    }

    return _dio!;
  }

  /// Post
  Future<Response> post({
    required String path,
    required dynamic postData,
    Options? options,
  }) async {
    final dio = getDio();
    return await dio.post(path, data: postData, options: options);
  }

  /// PATCH
  Future<Response> patch({
    required String path,
    required dynamic postData,
    Options? options,
  }) async {
    final dio = getDio();
    return await dio.patch(path, data: postData, options: options);
  }
}
