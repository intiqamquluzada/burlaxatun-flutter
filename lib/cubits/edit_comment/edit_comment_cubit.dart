import 'dart:developer';

import 'package:burla_xatun/data/contractor/edit_comment_contract.dart';
import 'package:burla_xatun/data/models/remote/response/forum_comments_model.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_comment_state.dart';

enum EditCommentStatus { inital, loading, error, networkError, success }

class EditCommentCubit extends Cubit<EditCommentState> {
  EditCommentCubit(this.editCommentContract) : super(EditCommentState());

  final EditCommentContract editCommentContract;

  Future<void> editComment({
    required int forumId,
    required String text,
    required int commentId,
    int? parentId,
  }) async {
    try {
      emit(state.copyWith(editCommentStatus: EditCommentStatus.loading));
      final response = await editCommentContract.editComment(
        commentId: commentId,
        forumId: forumId,
        text: text,
        parentId: parentId,
      );

      if (!response.statusCode.isSuccess) return;
      final editedComment = Comments.fromJson(response.data);
      emit(state.copyWith(
        editCommentStatus: EditCommentStatus.success,
        editedComment: editedComment,
      ));
    } catch (e, s) {
      log('Error occured while editing comment:$e', stackTrace: s);
      emit(state.copyWith(editCommentStatus: EditCommentStatus.error));
    }
  }
}
