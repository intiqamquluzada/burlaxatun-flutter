import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/forum_comment_contract.dart';
import '../../data/models/remote/response/forum_comments_model.dart';
import '../../utils/extensions/statuscode_extension.dart';

part 'forum_comments_state.dart';

enum ForumCommentStatus { initial, loading, error, networkError, success }

class ForumCommentsCubit extends Cubit<ForumCommentsState> {
  ForumCommentsCubit(this.forumCommentContract) : super(ForumCommentsState());

  final ForumCommentContract forumCommentContract;
  List<Comments> commentList = [];
  String? url = '';

  Future<void> getForumComments({
    required int forumId,
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      commentList = [];
      url = isRefresh ? '' : url;
    }
    if (url == null || state.forumCommentStatus == ForumCommentStatus.loading) {
      return;
    }
    try {
      emit(state.copyWith(forumCommentStatus: ForumCommentStatus.loading));
      final response = await forumCommentContract.getForumComments(
        forumId: forumId,
        url: url!.isEmpty ? null : url,
      );

      if (!response.statusCode.isSuccess) return;

      final data = ForumCommentsModel.fromJson(response.data);

      url = data.next;

      data.results?.forEach((e) {
        commentList.add(e);
      });

      emit(state.copyWith(
        forumCommentStatus: ForumCommentStatus.success,
        comments: List.from(commentList),
      ));
    } catch (e, s) {
      log('Error occured while getting comments: $e', stackTrace: s);
      emit(state.copyWith(forumCommentStatus: ForumCommentStatus.error));
    }
  }

  void updateListWithSendedComment(Comments sendedComment) {
    log('before send comment: ${commentList.length}');
    commentList.add(sendedComment);

    emit(state.copyWith(
      comments: List.from(commentList),
    ));
  }

  // List<Comments> sendedReplies = [];
  // void addCommentToSendedRepliesList(Comments sendedReply) {
  //   sendedReplies.insert(0, sendedReply);

  //   emit(state.copyWith(sendedReplies: List.from(sendedReplies)));
  // }

  void deleteCommentFromList(Comments deletedComment) {
    log('before delete comment: ${commentList.length}');

    commentList.remove(deletedComment);
    emit(state.copyWith(
      comments: List.from(commentList),
    ));
  }

  // void deleteReplyFromList() {}
}
