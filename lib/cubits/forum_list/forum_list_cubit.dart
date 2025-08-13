import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/forum_list_contractor.dart';
import '../../data/models/remote/response/forum_list_model.dart';
import '../../utils/extensions/statuscode_extension.dart';

part 'forum_list_state.dart';

enum ForumListStatus { initial, loading, success, error, netwokrError }

class ForumListCubit extends Cubit<ForumListState> {
  ForumListCubit(this.forumListContractor) : super(ForumListState());

  final ForumListContractor forumListContractor;
  List<Forum> forumList = [];
  String? url = '';

  Future<void> getForumList({int? categoryid, bool isRefresh = false}) async {
    if (isRefresh) {
      forumList = [];
      url = '';
    }
    if (url == null || state.forumListStatus == ForumListStatus.loading) {
      return;
    }
    try {
      emit(state.copyWith(forumListStatus: ForumListStatus.loading));
      final response = await forumListContractor.getForumList(
        categoryId: categoryid,
        url: url!.isEmpty ? null : url,
      );
      if (!response.statusCode.isSuccess) return;
      final data = ForumListModel.fromJson(response.data);

      url = data.next;

      data.results?.forEach((e) {
        forumList.add(e);
      });
      emit(state.copyWith(
        forumListStatus: ForumListStatus.success,
        forumList: List.from(forumList),
      ));
    } catch (e, s) {
      emit(state.copyWith(forumListStatus: ForumListStatus.error));
      log('Error occured while getting forum list by category id: $e',
          stackTrace: s);
    }
  }

  void addCreatedForumToList(Forum createdForum) {
    log('forum legth before add: ${state.forumList?.length}');
    forumList = state.forumList!;
    forumList.insert(0, createdForum);
    // forumList.insert(0, createdForum);
    emit(state.copyWith(
      forumList: List.from(forumList),
    ));
    log('forum legth after add: ${state.forumList?.length}');
  }

  // int page = 0;
  // bool canPagination = true;
  // List<Thread> forumList = [];

  // Future<void> getForumList({bool isRefresh = false}) async {
  //   if (state.forumListStatus == ForumListStatus.loading ||
  //       (!isRefresh && !canPagination)) {
  //     return;
  //   }
  //   isRefresh ? page = 1 : page += 1;
  //   canPagination = true;
  //   try {
  //     emit(state.copyWith(forumListStatus: ForumListStatus.loading));
  //     final response = await forumListContractor.getForumList(categoryId: 1);

  //     if (!response.statusCode.isSuccess) return;
  // final data = ForumListModel.fromJson(response.data);

  //     if (page == 1) {
  //       forumList = data.threads ?? [];
  //     } else {
  //       data.threads?.forEach((e) {
  //         forumList.add(e);
  //       });
  //     }

  //     emit(state.copyWith(
  //       forumList: List.from(forumList),
  //       forumListStatus: ForumListStatus.success,
  //     ));
  //   } catch (e, s) {
  //     canPagination = false;
  //     log('Erroru occured while getting forum list: $e', stackTrace: s);
  //     emit(state.copyWith(forumListStatus: ForumListStatus.error));
  //   }
  // }
}

    // page == 1
      //     ? forumList = data.threads ?? []
      //     : data.threads?.forEach((e) {
      //         forumList.add(e);
      //       });
