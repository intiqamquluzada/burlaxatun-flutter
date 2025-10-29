import 'dart:developer';

import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/forum_category_contractor.dart';
import '../../data/models/remote/response/forum_category_model.dart';

part 'forum_category_state.dart';

enum ForumCategoryStatus { initial, loading, error, success }

class ForumCategoryCubit extends Cubit<ForumCategoryState> {
  ForumCategoryCubit(this._categoryContractor) : super(ForumCategoryState());

  final ForumCategoryContractor _categoryContractor;
  List<ForumCategory> categoryList = [];
  String? url = '';

  Future<void> getForumCategory() async {
    if (url == null ||
        state.forumCategoryStatus == ForumCategoryStatus.loading) {
      return;
    }
    try {
      emit(state.copyWith(forumCategoryStatus: ForumCategoryStatus.loading));
      final response = await _categoryContractor.getForumCategory(
        url: url!.isEmpty ? null : url,
      );

      if (!response.statusCode.isSuccess) return;

      final data = ForumCategoryModel.fromJson(response.data);

      url = data.next;

      data.results?.forEach((e) {
        categoryList.add(e);
      });

      emit(state.copyWith(
        forumCategoryStatus: ForumCategoryStatus.success,
        categoryList: List.from(categoryList),
      ));
    } on DioException catch (e, s) {
      emit(state.copyWith(forumCategoryStatus: ForumCategoryStatus.error));
      log("Forum category dio exception: $e", stackTrace: s);
    } catch (e, s) {
      emit(state.copyWith(forumCategoryStatus: ForumCategoryStatus.error));
      log("Forum Category unknown error: $e", stackTrace: s);
    }
  }
}
