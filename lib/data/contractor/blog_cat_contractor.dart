import 'package:dio/dio.dart';

abstract class BlogCatContractor {
  Future<Response<dynamic>> getBlogCat({String? search});
}
