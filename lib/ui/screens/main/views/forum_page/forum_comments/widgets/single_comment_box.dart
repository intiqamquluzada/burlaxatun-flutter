import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/create_comment/create_comment_cubit.dart';
import '../../../../../../../cubits/main_cubit/main_state.dart';
import '../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../../data/models/remote/response/forum_comments_model.dart';
import '../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../../utils/extensions/context_extensions.dart';
import 'comment_datas.dart';
import 'reply_box.dart';
import 'sended_reply_box.dart';

class SingleCommentBox extends StatefulWidget {
  final int index;

  const SingleCommentBox({
    super.key,
    required this.index,
    required this.comment,
  });

  final Comments comment;

  @override
  State<SingleCommentBox> createState() => _SingleCommentBoxState();
}

class _SingleCommentBoxState extends State<SingleCommentBox>
    with AutomaticKeepAliveClientMixin {
  late ValueNotifier<bool> hasReplies;
  late CreateCommentCubit createCommentCubit;
  late ValueNotifier<List<Comments>> sendedCommentList;
  @override
  void initState() {
    hasReplies = ValueNotifier<bool>(widget.comment.replies!.isEmpty);
    createCommentCubit = context.read<CreateCommentCubit>();
    sendedCommentList = ValueNotifier<List<Comments>>([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final mainCubit = context.read<MainnCubit>();

    return Column(
      children: [
        GestureDetector(
          onLongPressStart: (details) {
            double fromTop = details.globalPosition.dy > 160
                ? details.globalPosition.dy - 160
                : 10;

            mainCubit.showMenuDialogAndEmojis(
              context,
              fromTop,
              widget.comment,
              createCommentCubit,
            );
            mainCubit.updateCommentBoxIndex(widget.index);
          },
          child: BlocBuilder<MainnCubit, MainInitial>(
            buildWhen: (previous, current) {
              return previous.commentBoxIndex != current.commentBoxIndex;
            },
            builder: (context, state) {
              return Material(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: widget.index == state.commentBoxIndex
                    ? Color(0xffFCE4EC)
                    : Colors.white,
                child: SizedBox(
                  width: context.deviceWidth,
                  child: Ink(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: widget.index == 0
                            ? null
                            : Border(
                                top: BorderSide(
                                  width: 2,
                                  color: Color(0xffE4E7EC),
                                ),
                              ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        onTap: () {},
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: CommentDatas(comment: widget.comment),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        BlocSelector<CreateCommentCubit, CreateCommentState,
            CreateCommentStatus>(
          selector: (state) {
            return state.createCommentStatus;
          },
          builder: (context, state) {
            if (state == CreateCommentStatus.replyLoading) {
              return widget.comment.id! ==
                      createCommentCubit.selectedComment.value?.id
                  ? CircularProgressIndicator.adaptive()
                  : SizedBox.shrink();
            }
            return SizedBox.shrink();
          },
        ),
        SendedReplyBox(
          parentId: widget.comment.id!,
          sendedComments: sendedCommentList,
        ),
        ValueListenableBuilder(
          valueListenable: hasReplies,
          builder: (context, value, child) {
            return Column(
              children: [
                Visibility(
                  visible: !value,
                  replacement: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.comment.replies!.length,
                    itemBuilder: (_, i) {
                      final replies = widget.comment.replies ?? [];
                      return ReplyBox(
                        reply: replies[i],
                      );
                    },
                  ),
                  child: TextButton(
                    onPressed: () {
                      hasReplies.value = true;
                    },
                    child: Text(
                      'show replies',
                      style: TextStyle(color: ColorConstants.primaryRedColor),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// class SingleCommentBox extends StatelessWidget {
//   const SingleCommentBox({super.key, required this.i});

//   final int i;

//   @override
//   Widget build(BuildContext context) {
//     final mainCubit = context.read<MainnCubit>();
//     return GestureDetector(
//       onLongPressStart: (details) {
//         log('${details.globalPosition.dy}');
//         double fromTop = details.globalPosition.dy > 160
//             ? details.globalPosition.dy - 160
//             : 10;
//         mainCubit.showMenuDialogAndEmojis(context, fromTop);
//         mainCubit.updateCommentBoxIndex(i);
//       },
//       child: BlocBuilder<MainnCubit, MainInitial>(
//         buildWhen: (previous, current) {
//           return previous.commentBoxIndex != current.commentBoxIndex;
//         },
//         builder: (context, state) {
//           return Material(
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//             color:
//                 i == state.commentBoxIndex ? Color(0xffFCE4EC) : Colors.white,
//             child: SizedBox(
//               width: context.deviceWidth,
//               child: Ink(
//                 child: DecoratedBox(
//                   decoration: BoxDecoration(
//                     border: i == 0
//                         ? null
//                         : Border(
//                             top: BorderSide(
//                               width: 2,
//                               color: Color(0xffE4E7EC),
//                             ),
//                           ),
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                   ),
//                   child: InkWell(
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                     onTap: () {},
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: CommentDatas(),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
