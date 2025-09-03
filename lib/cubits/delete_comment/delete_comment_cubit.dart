import 'dart:developer';

import 'package:burla_xatun/data/contractor/delete_comment_contract.dart';
import 'package:burla_xatun/data/models/remote/response/forum_comments_model.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_comment_state.dart';

enum DeleteCommentStatus { initial, loading, success, error }

class DeleteCommentCubit extends Cubit<DeleteCommentState> {
  DeleteCommentCubit(this.deleteCommentContract) : super(DeleteCommentState());

  final DeleteCommentContract deleteCommentContract;
  final ValueNotifier<Comments?> deletedComment =
      ValueNotifier<Comments?>(null);

  Future<Comments?> deleteComment({
    required int commentId,
    required Comments deletedComment,
  }) async {
    try {
      emit(state.copyWith(deleteCommentStatus: DeleteCommentStatus.loading));
      final response =
          await deleteCommentContract.deleteComment(commentId: commentId);

      if (!response.statusCode.isSuccess) return null;
      emit(state.copyWith(
        deleteCommentStatus: DeleteCommentStatus.success,
        deletedComment: deletedComment,
      ));
      return deletedComment;
    } catch (e, s) {
      log('error occured while deleting comment: $e', stackTrace: s);
      emit(state.copyWith(deleteCommentStatus: DeleteCommentStatus.error));
      return null;
    }
  }
}
