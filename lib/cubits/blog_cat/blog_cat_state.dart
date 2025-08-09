part of 'blog_cat_cubit.dart';

final class BlogCatState extends Equatable {
  const BlogCatState({
    this.status = BlogCatStatus.initial,
    this.categoryList,
    this.errorMessage,
  });

  final BlogCatStatus status;
  final List<BlogCategoryModel>? categoryList;
  final String? errorMessage;

  BlogCatState copyWith({
    BlogCatStatus? status,
    List<BlogCategoryModel>? categoryList,
    String? errorMessage,
  }) {
    return BlogCatState(
      status: status ?? this.status,
      categoryList: categoryList ?? this.categoryList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, categoryList, errorMessage];
}
