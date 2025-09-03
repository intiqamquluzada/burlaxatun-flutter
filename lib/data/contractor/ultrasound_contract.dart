import 'package:dio/dio.dart';

abstract class UltrasoundContract {
  Future<Response<dynamic>> getUltraSound({required int week});
}
