import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/create_comment/create_comment_cubit.dart';
import '../../../../../../../data/models/remote/response/forum_comments_model.dart';
import 'reply_box.dart';

class SendedReplyBox extends StatefulWidget {
  const SendedReplyBox({
    super.key,
    required this.parentId,
    required this.parentTag,
    // required this.sendedReplies,
  });

  final int parentId;
  final String parentTag;
  // final ValueNotifier<List<Comments>> sendedReplies;

  @override
  State<SendedReplyBox> createState() => _SendedReplyBoxState();
}

class _SendedReplyBoxState extends State<SendedReplyBox> {
  @override
  Widget build(BuildContext context) {
    final CreateCommentCubit createCommentCubit =
        context.read<CreateCommentCubit>();
    // final ValueNotifier<List<Comments>> sendedReplies =
    //     ValueNotifier<List<Comments>>([]);

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
        BlocSelector<CreateCommentCubit, CreateCommentState, List<Comments>?>(
          selector: (state) {
            return state.sendedReplies ?? [];
          },
          builder: (context, sendedReplies) {
            return sendedReplies != null && sendedReplies.isNotEmpty
                ? Column(
                    children: [
                      for (int i = 0; i < sendedReplies.length; i++)
                        Visibility(
                          visible: sendedReplies[i].parent == widget.parentId,
                          child: ReplyBox(
                            reply: sendedReplies[i],
                            boxIndex: i,
                            parentReplies: null,
                            parentTag: widget.parentTag,
                          ),
                        ),
                    ],
                  )
                : SizedBox.shrink();
          },
        ),
      ],
    );
  }
}


// BlocConsumer<CreateCommentCubit, CreateCommentState>(
        //   listener: (context, state) {
        //     // if (state.createCommentStatus == CreateCommentStatus.replySuccess) {
        //     //   log('success created');
        //     //   // createCommentCubit
        //     //   //     .addCommentToSendedRepliesList(state.sendedComment!);
        //     // }
        //   },
        //   builder: (context, state) {
        //     sendedReplies.value = state.sendedReplies ?? [];
        //     return Column(
        //       children: [
        //         if (state.createCommentStatus ==
        //                 CreateCommentStatus.replyLoading &&
        //             widget.parentId ==
        //                 createCommentCubit.selectedComment.value?.id)
        //           CircularProgressIndicator.adaptive()
        //         else
        //           SizedBox.shrink(),
        //         state.sendedReplies == null
        //             ? ValueListenableBuilder(
        //                 valueListenable: createCommentCubit.sendedReplies,
        //                 builder: (context, list, child) {
        //                   return Column(
        //                     children: [
        //                       for (int i = 0; i < list.length; i++)
        //                         Visibility(
        //                           visible: list[i].parent == widget.parentId,
        //                           child: ReplyBox(
        //                             reply: list[i],
        //                             boxIndex: i,
        //                           ),
        //                         ),
        //                     ],
        //                   );
        //                 },
        //               )
        //             : SizedBox.shrink(),
        //       ],
        //     );
        //   },
        // ),