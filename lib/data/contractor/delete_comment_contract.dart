import 'package:dio/dio.dart';

abstract class DeleteCommentContract {
  Future<Response<dynamic>> deleteComment({required int commentId});
}
