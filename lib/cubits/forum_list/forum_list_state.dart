part of 'forum_list_cubit.dart';

class ForumListState extends Equatable {
  const ForumListState({
    this.forumListStatus = ForumListStatus.initial,
    this.forumList,
  });

  final ForumListStatus? forumListStatus;
  final List<Forum>? forumList;

  @override
  List<Object?> get props => [forumListStatus, forumList];

  ForumListState copyWith({
    ForumListStatus? forumListStatus,
    List<Forum>? forumList,
  }) {
    return ForumListState(
      forumListStatus: forumListStatus ?? this.forumListStatus,
      forumList: forumList ?? this.forumList,
    );
  }
}
