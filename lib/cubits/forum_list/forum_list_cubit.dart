import 'dart:developer';

import 'package:burla_xatun/data/models/remote/response/forum_list_model.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/forum_list_contractor.dart';

part 'forum_list_state.dart';

enum ForumListStatus { initial, loading, success, error, netwokrError }

class ForumListCubit extends Cubit<ForumListState> {
  ForumListCubit(this.forumListContractor) : super(ForumListState());

  final ForumListContractor forumListContractor;

  int page = 0;
  List<Thread> forumList = [];

  Future<void> getForumList({bool isRefresh = false}) async {
    if (state.forumListStatus == ForumListStatus.loading) return;
    isRefresh ? page = 1 : page += 1;
    try {
      emit(state.copyWith(forumListStatus: ForumListStatus.loading));
      final response = await forumListContractor.getForumList(page: page);

      if (!response.statusCode.isSuccess) return;
      final data = ForumListModel.fromJson(response.data);
      if (page == 1) {
        forumList = data.threads ?? [];
      } else {
        data.threads?.forEach((e) {
          forumList.add(e);
        });
      }
      emit(state.copyWith(
        forumList: List.from(forumList),
        forumListStatus: ForumListStatus.success,
      ));
    } catch (e, s) {
      log('Erroru occured while getting forum list: $e', stackTrace: s);
      emit(state.copyWith(forumListStatus: ForumListStatus.error));
    }
  }
}
