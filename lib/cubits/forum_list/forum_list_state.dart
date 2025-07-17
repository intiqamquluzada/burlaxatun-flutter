part of 'forum_list_cubit.dart';

class ForumListState extends Equatable {
  const ForumListState({
    this.forumListStatus = ForumListStatus.initial,
    this.forumList,
  });

  final ForumListStatus? forumListStatus;
  final List<Thread>? forumList;

  @override
  List<Object?> get props => [forumListStatus, forumList];

  ForumListState copyWith({
    ForumListStatus? forumListStatus,
    List<Thread>? forumList,
  }) {
    return ForumListState(
      forumListStatus: forumListStatus ?? this.forumListStatus,
      forumList: forumList ?? this.forumList,
    );
  }
}
