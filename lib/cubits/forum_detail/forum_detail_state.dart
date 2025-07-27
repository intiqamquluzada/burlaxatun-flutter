part of 'forum_detail_cubit.dart';

class ForumDetailState extends Equatable {
  const ForumDetailState({
    this.forumDetailStatus = ForumDetailStatus.initial,
    this.forumDetail,
  });

  final ForumDetailStatus? forumDetailStatus;
  final Forum? forumDetail;

  @override
  List<Object?> get props => [
        forumDetailStatus,
        forumDetail,
      ];

  ForumDetailState copyWith({
    ForumDetailStatus? forumDetailStatus,
    Forum? forumDetail,
  }) {
    return ForumDetailState(
      forumDetailStatus: forumDetailStatus ?? this.forumDetailStatus,
      forumDetail: forumDetail ?? this.forumDetail,
    );
  }
}
