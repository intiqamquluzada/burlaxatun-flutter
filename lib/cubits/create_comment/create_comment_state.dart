part of 'create_comment_cubit.dart';

class CreateCommentState extends Equatable {
  const CreateCommentState({
    this.createCommentStatus = CreateCommentStatus.inital,
    this.sendedComment,
    this.sendedReplies,
  });

  final CreateCommentStatus createCommentStatus;
  final Comments? sendedComment;
  final List<Comments>? sendedReplies;

  @override
  List<Object?> get props => [
        createCommentStatus,
        sendedComment,
        sendedReplies,
      ];

  CreateCommentState copyWith({
    CreateCommentStatus? createCommentStatus,
    Comments? sendedComment,
    List<Comments>? sendedReplies,
  }) {
    return CreateCommentState(
      createCommentStatus: createCommentStatus ?? this.createCommentStatus,
      sendedComment: sendedComment ?? this.sendedComment,
      sendedReplies: sendedReplies ?? this.sendedReplies,
    );
  }
}
