import 'package:dio/dio.dart';

abstract class ReportOrBlockContract {
  Future<Response<dynamic>> reportComment({required int commentId});

  Future<Response<dynamic>> blockUser({required int userId});

  Future<Response<dynamic>> reportForum({required int forumId});

  Future<Response<dynamic>> blockForum({required int forumId});
}
