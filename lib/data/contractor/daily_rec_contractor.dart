import 'package:dio/dio.dart';

abstract class DailyRecContractor {
  Future<Response<dynamic>> getDailyRec({int? day});
}
