import 'package:dio/dio.dart';

abstract class IndicatorContract {
  Future<Response<dynamic>> getIndicator({
    int? babyId,
    required String indicatorName,
    required String range,
  });

  Future<Response<dynamic>> addIndicator({
    required Map<String, dynamic> postData,
  });
}
