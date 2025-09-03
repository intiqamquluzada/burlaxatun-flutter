import 'package:dio/dio.dart';

abstract class ForumCommentContract {
  Future<Response<dynamic>> getForumComments({
    required int forumId,
    String? url,
  });
}
