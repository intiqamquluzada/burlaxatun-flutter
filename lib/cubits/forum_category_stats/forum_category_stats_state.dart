part of 'forum_category_stats_cubit.dart';

class ForumCategoryStatsState extends Equatable { 
  const ForumCategoryStatsState({
    this.categoryStatsStatus = CategoryStatsStatus.inital,
    this.categoryStatsList,
  });

  final CategoryStatsStatus categoryStatsStatus;
  final List<ForumCategoryStats>? categoryStatsList;

  @override
  List<Object?> get props => [categoryStatsStatus, categoryStatsList];

  ForumCategoryStatsState copyWith({
    CategoryStatsStatus? categoryStatsStatus,
    List<ForumCategoryStats>? categoryStatsList,
  }) {
    return ForumCategoryStatsState(
      categoryStatsStatus: categoryStatsStatus ?? this.categoryStatsStatus,
      categoryStatsList: categoryStatsList ?? this.categoryStatsList,
    );
  }
}
