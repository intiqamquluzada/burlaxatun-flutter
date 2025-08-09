import 'dart:developer';

import 'package:burla_xatun/data/contractor/blogs_by_category_contract.dart';
import 'package:burla_xatun/data/models/remote/response/blogs_by_category_model.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'blogs_by_category_state.dart';

enum BlogsByCategoryStatus { initial, loading, error, success, networkError }

class BlogsByCategoryCubit extends Cubit<BlogsByCategoryState> {
  BlogsByCategoryCubit(this.blogsByCategoryContract)
      : super(BlogsByCategoryState());
  final BlogsByCategoryContract blogsByCategoryContract;

  List<BlogByCategory> blogsByCategory = [];
  String? url = '';
  Future<void> getBlogsByCategory({
    required int categoryId,
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      blogsByCategory = [];
      url = isRefresh ? '' : url;
      emit(state.copyWith(blogsByCategory: []));
    }
    if (url == null || state.status == BlogsByCategoryStatus.loading) {
      return;
    }
    try {
      emit(state.copyWith(status: BlogsByCategoryStatus.loading));
      final response = await blogsByCategoryContract.getBlogsByCategory(
        categoryId: categoryId,
        url: url!.isEmpty ? null : url,
      );

      if (!response.statusCode.isSuccess) return;

      final data = BlogsByCategoryModel.fromJson(response.data);

      url = data.next;

      data.results?.forEach((e) {
        blogsByCategory.add(e);
      });

      emit(state.copyWith(
        status: BlogsByCategoryStatus.success,
        blogsByCategory: List.from(blogsByCategory),
      ));
    } catch (e, s) {
      log('Error occured while getting blogs by category: $e', stackTrace: s);
      emit(state.copyWith(status: BlogsByCategoryStatus.error));
    }
  }
}
