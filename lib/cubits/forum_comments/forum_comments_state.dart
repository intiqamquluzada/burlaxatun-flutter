part of 'forum_comments_cubit.dart';

class ForumCommentsState extends Equatable {
  const ForumCommentsState({
    this.forumCommentStatus = ForumCommentStatus.initial,
    this.comments,
    this.sendedReplies,
  });

  final ForumCommentStatus forumCommentStatus;
  final List<Comments>? comments;
  final List<Comments>? sendedReplies;

  @override
  List<Object?> get props => [forumCommentStatus, comments, sendedReplies];

  ForumCommentsState copyWith({
    ForumCommentStatus? forumCommentStatus,
    List<Comments>? comments,
    List<Comments>? sendedReplies,
  }) {
    return ForumCommentsState(
      forumCommentStatus: forumCommentStatus ?? this.forumCommentStatus,
      comments: comments ?? this.comments,
      sendedReplies: sendedReplies ?? this.sendedReplies,
    );
  }
}
