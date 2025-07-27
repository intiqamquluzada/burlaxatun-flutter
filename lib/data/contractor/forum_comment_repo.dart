import 'package:dio/src/response.dart';

import '../services/remote/forum_comment_service.dart';
import 'forum_comment_contract.dart';

class ForumCommentRepo implements ForumCommentContract {
  ForumCommentRepo(this._forumCommentService);

  final ForumCommentService _forumCommentService;

  @override
  Future<Response> getForumComments({required int forumId, String? url}) {
    return _forumCommentService.getForumComments(forumId: forumId, url: url);
  }
}
