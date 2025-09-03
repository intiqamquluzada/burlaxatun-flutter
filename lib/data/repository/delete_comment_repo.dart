import '../contractor/delete_comment_contract.dart';
import '../services/remote/delete_comment_service.dart';
import 'package:dio/src/response.dart';

class DeleteCommentRepo implements DeleteCommentContract {
  DeleteCommentRepo(this.deleteCommentService);

  final DeleteCommentService deleteCommentService;

  @override
  Future<Response> deleteComment({required int commentId}) {
    return deleteCommentService.deleteComment(commentId: commentId);
  }
}
