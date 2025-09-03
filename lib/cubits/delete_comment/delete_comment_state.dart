part of 'delete_comment_cubit.dart';

class DeleteCommentState extends Equatable {
  const DeleteCommentState({
    this.deleteCommentStatus = DeleteCommentStatus.initial,
    this.deletedComment,
  });

  final DeleteCommentStatus deleteCommentStatus;
  final Comments? deletedComment;

  @override
  List<Object?> get props => [
        deleteCommentStatus,
        deletedComment,
      ];

  DeleteCommentState copyWith({
    DeleteCommentStatus? deleteCommentStatus,
    Comments? deletedComment,
  }) {
    return DeleteCommentState(
      deleteCommentStatus: deleteCommentStatus ?? this.deleteCommentStatus,
      deletedComment: deletedComment ?? this.deletedComment,
    );
  }
}
