import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/blog_cat_contractor.dart';
import '../../data/models/remote/response/blog_category_model.dart';

part 'blog_cat_state.dart';

enum BlogCatStatus { initial, loading, success, failure, networkError }

class BlogCatCubit extends Cubit<BlogCatState> {
  BlogCatCubit(this._blogCatContractor) : super(BlogCatState());

  final BlogCatContractor _blogCatContractor;

  Future<void> getBlogCat() async {
    if (state.categoryList != null) return;
    try {
      emit(state.copyWith(status: BlogCatStatus.loading));

      final response = await _blogCatContractor.getBlogCat();

      if (!response.statusCode.isSuccess) return;
      final data = response.data as List;

      final categoryList =
          data.map((e) => BlogCategoryModel.fromJson(e)).toList();

      emit(state.copyWith(
        status: BlogCatStatus.success,
        categoryList: categoryList,
      ));
    } on DioException catch (e) {
      emit(state.copyWith(
        status: BlogCatStatus.networkError,
        errorMessage: e.toString(),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BlogCatStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
