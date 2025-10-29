import 'package:dio/dio.dart';

abstract class ForumCategoryContractor {
  Future<Response> getForumCategory({String? url});
}
