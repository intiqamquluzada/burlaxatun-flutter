import 'package:dio/dio.dart';

abstract class PregnancyProgressContract {
  Future<Response<dynamic>> getPregnancyProgress({required String week});
}
