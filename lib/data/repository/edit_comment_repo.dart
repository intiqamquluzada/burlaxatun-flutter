import 'package:burla_xatun/data/contractor/edit_comment_contract.dart';
import 'package:burla_xatun/data/services/remote/edit_comment_service.dart';
import 'package:dio/src/response.dart';

class EditCommentRepo implements EditCommentContract {
  EditCommentRepo(this.editCommentService);

  final EditCommentService editCommentService;

  @override
  Future<Response> editComment({
    required int forumId,
    required String text,
    required int? parentId,
    required int commentId,
  }) {
    return editCommentService.editComment(
      forumId: forumId,
      text: text,
      parentId: parentId,
      commentId: commentId,
    );
  }
}
