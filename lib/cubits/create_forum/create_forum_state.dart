part of 'create_forum_cubit.dart';

class CreateForumState extends Equatable {
  const CreateForumState({
    this.createForumStatus = CreateForumStatus.initial,
    this.createdForum,
  });

  final CreateForumStatus createForumStatus;
  final Forum? createdForum;

  @override
  List<Object?> get props => [createForumStatus, createdForum];

  CreateForumState copyWith({
    CreateForumStatus? createForumStatus,
    Forum? createdForum,
  }) {
    return CreateForumState(
      createForumStatus: createForumStatus ?? this.createForumStatus,
      createdForum: createdForum ?? this.createdForum,
    );
  }
}
