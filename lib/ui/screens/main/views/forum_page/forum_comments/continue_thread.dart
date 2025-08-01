import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../data/models/remote/response/forum_comments_model.dart';
import 'widgets/comment_input.dart';
import 'widgets/single_comment_box.dart';

class ContinueThread extends StatefulWidget {
  const ContinueThread({
    super.key,
    required this.index,
    required this.comment,
    required this.pageContext,
    this.replies,
  });

  final int index;
  final Comments comment;
  final BuildContext pageContext;
  final ValueNotifier<List<Comments>>? replies;

  @override
  State<ContinueThread> createState() => _ContinueThreadState();
}

class _ContinueThreadState extends State<ContinueThread> {
  late MainnCubit mainnCubit;
  late List<ValueNotifier<List<Comments>>> replyList;
  @override
  void initState() {
    mainnCubit = context.read<MainnCubit>();
    mainnCubit.commentInputTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    mainnCubit.commentInputTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cavabın davamı'),
      ),
      body: SingleCommentBox(
        index: widget.index,
        comment: widget.comment,
        replies: widget.replies,
      ),
      bottomSheet: CommentInput(
        forumId: widget.comment.forum ?? -1,
        commentInputTextController: mainnCubit.commentInputTextController,
      ),
    );
  }
}
