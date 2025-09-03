import 'package:dio/dio.dart';

abstract class ForumCategoryStatsContract {
  Future<Response<dynamic>> getCategoryStats();
}
