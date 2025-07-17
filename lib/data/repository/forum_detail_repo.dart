import 'package:burla_xatun/data/contractor/forum_detail_contract.dart';
import 'package:burla_xatun/data/services/remote/forum_detail_service.dart';
import 'package:dio/dio.dart';

class ForumDetailRepo implements ForumDetailContract {
  ForumDetailRepo(this.forumDetailService);

  final ForumDetailService forumDetailService;

  @override
  Future<Response<dynamic>> getForumDetail({required int postId}) {
    return forumDetailService.getForumDetail(postId: postId);
  }
}
