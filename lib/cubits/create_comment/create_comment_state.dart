part of 'create_comment_cubit.dart';

class CreateCommentState extends Equatable {
  const CreateCommentState({
    this.createCommentStatus = CreateCommentStatus.inital,
    this.sendedComment,
  });

  final CreateCommentStatus createCommentStatus;
  final Comments? sendedComment;

  @override
  List<Object?> get props => [createCommentStatus, sendedComment];

  CreateCommentState copyWith({
    CreateCommentStatus? createCommentStatus,
    Comments? sendedComment,
  }) {
    return CreateCommentState(
      createCommentStatus: createCommentStatus ?? this.createCommentStatus,
      sendedComment: sendedComment ?? this.sendedComment,
    );
  }
}
