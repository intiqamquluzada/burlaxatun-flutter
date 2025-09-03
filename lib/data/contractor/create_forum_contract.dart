import 'package:dio/dio.dart';

abstract class CreateForumContract {
  Future<Response<dynamic>> createForum({
    required int categoryId,
    required String text,
  });
}
