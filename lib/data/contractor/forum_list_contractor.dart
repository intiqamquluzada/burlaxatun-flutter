import 'package:dio/dio.dart';

abstract class ForumListContractor {
  Future<Response<dynamic>> getForumList({
    int? categoryId,
    String? url,
  });
}
