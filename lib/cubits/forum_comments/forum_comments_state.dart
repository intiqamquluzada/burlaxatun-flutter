part of 'forum_comments_cubit.dart';

class ForumCommentsState extends Equatable {
  const ForumCommentsState({
    this.forumCommentStatus = ForumCommentStatus.initial,
    this.comments,
  });

  final ForumCommentStatus forumCommentStatus;
  final List<Comments>? comments;

  @override
  List<Object?> get props => [forumCommentStatus, comments];

  ForumCommentsState copyWith({
    ForumCommentStatus? forumCommentStatus,
    List<Comments>? comments,
  }) {
    return ForumCommentsState(
      forumCommentStatus: forumCommentStatus ?? this.forumCommentStatus,
      comments: comments ?? this.comments,
    );
  }
}
