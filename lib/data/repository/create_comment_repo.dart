import 'package:dio/src/response.dart';

import '../contractor/create_comment_contract.dart';
import '../services/remote/create_comment_service.dart';

class CreateCommentRepo implements CreateCommentContract {
  CreateCommentRepo(this.createCommentService);

  final CreateCommentService createCommentService;

  @override
  Future<Response> sendComment({
    required int forumId,
    required String text,
    int? parentId,
  }) {
    return createCommentService.sendComment(
      forumId: forumId,
      text: text,
      parentId: parentId,
    );
  }
}
