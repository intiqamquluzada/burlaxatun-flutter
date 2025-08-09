import 'package:dio/dio.dart';

abstract class BlogsByCategoryContract {
  Future<Response<dynamic>> getBlogsByCategory({
    required int categoryId,
    String? url,
  });
}
