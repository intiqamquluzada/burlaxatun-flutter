part of 'forum_detail_cubit.dart';

class ForumDetailState extends Equatable {
  const ForumDetailState({
    this.forumDetailStatus = ForumDetailStatus.initial,
    // this.post,
  });

  final ForumDetailStatus? forumDetailStatus;
  // final Post? post;

  @override
  List<Object?> get props => [
        forumDetailStatus,
        // post,
      ];

  ForumDetailState copyWith({
    ForumDetailStatus? forumDetailStatus,
    // Post? post,
  }) {
    return ForumDetailState(
      forumDetailStatus: forumDetailStatus ?? this.forumDetailStatus,
      // post: post ?? this.post,
    );
  }
}
