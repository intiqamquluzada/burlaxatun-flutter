import 'dart:developer';

import 'package:burla_xatun/data/contractor/create_comment_contract.dart';
import 'package:burla_xatun/data/models/remote/response/forum_comments_model.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_comment_state.dart';

enum CreateCommentStatus {
  inital,
  commentLoading,
  replyLoading,
  error,
  networkError,
  commentSuccess,
  replySuccess,
}

class CreateCommentCubit extends Cubit<CreateCommentState> {
  CreateCommentCubit(this.createCommentContract) : super(CreateCommentState());

  final CreateCommentContract createCommentContract;
  ValueNotifier<Comments?> selectedComment = ValueNotifier<Comments?>(null);

  Future<void> sendComment({
    required int forumId,
    required String text,
    // int? parentId,
  }) async {
    try {
      emit(state.copyWith(
        createCommentStatus: selectedComment.value?.id == null
            ? CreateCommentStatus.commentLoading
            : CreateCommentStatus.replyLoading,
      ));
      final response = await createCommentContract.sendComment(
        forumId: forumId,
        text: text,
        parentId: selectedComment.value?.id,
      );

      if (!response.statusCode.isSuccess) return;
      final sendedComment = Comments.fromJson(response.data);
      emit(state.copyWith(
        createCommentStatus: selectedComment.value?.id == null
            ? CreateCommentStatus.commentSuccess
            : CreateCommentStatus.replySuccess,
        sendedComment: sendedComment,
      ));
    } catch (e, s) {
      log('Error occured while creating comment: $e', stackTrace: s);
      emit(state.copyWith(createCommentStatus: CreateCommentStatus.error));
    }
  }
}

// successde liste elave edirik (forum commentdeki liste) blocconsumerde
