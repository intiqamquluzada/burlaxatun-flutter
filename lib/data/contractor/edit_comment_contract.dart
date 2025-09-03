import 'package:dio/dio.dart';

abstract class EditCommentContract {
  Future<Response<dynamic>> editComment({
    required int forumId,
    required String text,
    required int? parentId,
    required int commentId,
  });
}
