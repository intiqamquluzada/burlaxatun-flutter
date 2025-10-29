part of 'forum_category_cubit.dart';


class ForumCategoryState extends Equatable {
  const ForumCategoryState({
    this.forumCategoryStatus = ForumCategoryStatus.initial,
    this.categoryList,
  });

  final ForumCategoryStatus forumCategoryStatus;
  final List<ForumCategory>? categoryList;

  @override
  List<Object?> get props => [
        forumCategoryStatus,
        categoryList,
      ];

  ForumCategoryState copyWith({
    ForumCategoryStatus? forumCategoryStatus,
    List<ForumCategory>? categoryList,
  }) {
    return ForumCategoryState(
      forumCategoryStatus: forumCategoryStatus ?? this.forumCategoryStatus,
      categoryList: categoryList ?? this.categoryList,
    );
  }
}
