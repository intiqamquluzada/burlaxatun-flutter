import 'dart:developer';

import 'package:burla_xatun/data/contractor/forum_detail_contract.dart';
import 'package:burla_xatun/data/models/remote/response/forum_list_model.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'forum_detail_state.dart';

enum ForumDetailStatus { initial, loading, error, networkError, success }

class ForumDetailCubit extends Cubit<ForumDetailState> {
  ForumDetailCubit(this.forumDetailContract) : super(ForumDetailState());

  final ForumDetailContract forumDetailContract;

  Future<void> getForumDetail(int postId) async {
    try {
      emit(state.copyWith(forumDetailStatus: ForumDetailStatus.loading));
      final response = await forumDetailContract.getForumDetail(postId: postId);
      if (response.statusCode.isSuccess) {
        // final post = Post.fromJson(response.data);
        emit(state.copyWith(
          forumDetailStatus: ForumDetailStatus.success,
          // post: post,
        ));
      } else {
        log('Error occured while getting forum detail');
        emit(state.copyWith(forumDetailStatus: ForumDetailStatus.error));
      }
    } catch (e, s) {
      log('Error occured while getting forum detail: $e', stackTrace: s);
      emit(state.copyWith(forumDetailStatus: ForumDetailStatus.error));
    }
  }
}
