import 'package:burla_xatun/cubits/create_comment/create_comment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../data/models/remote/response/forum_comments_model.dart';
import 'reply_box.dart';

class SendedReplyBox extends StatefulWidget {
  const SendedReplyBox({
    super.key,
    required this.parentId,
    required this.sendedComments,
  });

  final int parentId;
  final ValueNotifier<List<Comments>> sendedComments;

  @override
  State<SendedReplyBox> createState() => _SendedReplyBoxState();
}

class _SendedReplyBoxState extends State<SendedReplyBox> {
  @override
  Widget build(BuildContext context) {
    final CreateCommentCubit createCommentCubit =
        context.read<CreateCommentCubit>();
    return Column(
      children: [
        BlocSelector<CreateCommentCubit, CreateCommentState,
            CreateCommentStatus>(
          selector: (state) {
            return state.createCommentStatus;
          },
          builder: (context, state) {
            if (state == CreateCommentStatus.replyLoading &&
                widget.parentId ==
                    createCommentCubit.selectedComment.value?.id) {
              return CircularProgressIndicator.adaptive();
            }
            return SizedBox.shrink();
          },
        ),
        BlocConsumer<CreateCommentCubit, CreateCommentState>(
          listener: (context, state) {
            if (state.createCommentStatus == CreateCommentStatus.replySuccess) {
              widget.sendedComments.value.insert(0, state.sendedComment!);
            }
          },
          builder: (context, state) {
            return ValueListenableBuilder(
              valueListenable: widget.sendedComments,
              builder: (context, sendedComments, child) {
                return Column(
                  children: [
                    for (int i = 0; i < sendedComments.length; i++)
                      Visibility(
                        visible: sendedComments[i].parent == widget.parentId,
                        child: ReplyBox(reply: sendedComments[i]),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
