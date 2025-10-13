import 'dart:developer';

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

  Future<void> getBlogCat({String? search}) async {
    try {
      emit(state.copyWith(status: BlogCatStatus.loading));

      final response = await _blogCatContractor.getBlogCat(search: search);

      if (!response.statusCode.isSuccess) return;
      final data = response.data as List;

      final categoryList =
          data.map((e) => BlogCategoryModel.fromJson(e)).toList();

      emit(state.copyWith(
        status: BlogCatStatus.success,
        categoryList: categoryList,
      ));
    } on DioException catch (e) {
      log('error occured while getting blogs with categories: $e');
      emit(state.copyWith(
        status: BlogCatStatus.networkError,
        errorMessage: 'Xəta baş verdi',
      ));
    } catch (e) {
      log('error occured while getting blogs with categories: $e');
      emit(state.copyWith(
        status: BlogCatStatus.failure,
        errorMessage: 'Xəta baş verdi',
      ));
    }
  }
}
