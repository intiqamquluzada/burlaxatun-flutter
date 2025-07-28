import 'package:dio/dio.dart';

abstract class CreateCommentContract {
  Future<Response<dynamic>> sendComment({
    required int forumId,
    required String text,
    int? parentId,
  });
}
