part of 'blogs_by_category_cubit.dart';

class BlogsByCategoryState extends Equatable {
  const BlogsByCategoryState({
    this.status = BlogsByCategoryStatus.initial,
    this.blogsByCategory,
  });

  final BlogsByCategoryStatus status;
  final List<BlogByCategory>? blogsByCategory;

  @override
  List<Object?> get props => [status, blogsByCategory];

  BlogsByCategoryState copyWith({
    BlogsByCategoryStatus? status,
    List<BlogByCategory>? blogsByCategory,
  }) {
    return BlogsByCategoryState(
      status: status ?? this.status,
      blogsByCategory: blogsByCategory ?? this.blogsByCategory,
    );
  }
}
