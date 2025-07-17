import 'package:dio/dio.dart';

abstract class ForumDetailContract {
  Future<Response<dynamic>> getForumDetail({required int postId});
}
