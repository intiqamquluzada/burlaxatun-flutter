part of 'forum_category_cubit.dart';

// abstract class ForumCategoryiState extends Equatable {
//   const ForumCategoryiState();

//   @override
//   List<Object> get props => [];
// }
sealed class ForumCategoryState {}

final class ForumCategoryInitial extends ForumCategoryState {}

final class ForumCategoryLoading extends ForumCategoryState {}

final class ForumCategorySuccess extends ForumCategoryState {
  ForumCategorySuccess(this.response);

  final List<ForumCategory> response;
}

final class ForumCategoryError extends ForumCategoryState {
  ForumCategoryError(this.message);

  final String message;
}

final class ForumCategoryNetworkError extends ForumCategoryState {
  ForumCategoryNetworkError(this.message);

  final String message;
}
