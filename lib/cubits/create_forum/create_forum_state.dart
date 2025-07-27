part of 'create_forum_cubit.dart';

class CreateForumState extends Equatable {
  const CreateForumState({
    this.createForumStatus = CreateForumStatus.initial,
  });

  final CreateForumStatus createForumStatus;

  @override
  List<Object> get props => [createForumStatus];

  CreateForumState copyWith({
    CreateForumStatus? createForumStatus,
  }) {
    return CreateForumState(
      createForumStatus: createForumStatus ?? this.createForumStatus,
    );
  }
}
