part of 'edit_comment_cubit.dart';

class EditCommentState extends Equatable {
  const EditCommentState({
    this.editCommentStatus = EditCommentStatus.inital,
    this.editedComment,
  });

  final EditCommentStatus editCommentStatus;
  final Comments? editedComment;

  @override
  List<Object?> get props => [
        editCommentStatus,
        editedComment,
      ];

  EditCommentState copyWith({
    EditCommentStatus? editCommentStatus,
    Comments? editedComment,
  }) {
    return EditCommentState(
      editCommentStatus: editCommentStatus ?? this.editCommentStatus,
      editedComment: editedComment ?? this.editedComment,
    );
  }
}
