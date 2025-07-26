import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/forum_category_contractor.dart';
import '../../data/models/remote/response/forum_category_model.dart';

part 'forum_category_state.dart';

class ForumCategoryCubit extends Cubit<ForumCategoryState> {
  ForumCategoryCubit(this._categoryContractor) : super(ForumCategoryInitial());

  final ForumCategoryContractor _categoryContractor;

  Future<void> getForumCategory() async {
    try {
      emit(ForumCategoryLoading());
      final response = await _categoryContractor.getForumCategory();
      emit(ForumCategorySuccess(response));
    } on DioException catch (e, s) {
      emit(ForumCategoryNetworkError(e.toString()));
      log("Forum category dio exception: $e", stackTrace: s);
    } catch (e, s) {
      emit(ForumCategoryError(e.toString()));
      log("Forum Category unknown error: $e", stackTrace: s);
    }
  }

  
}
