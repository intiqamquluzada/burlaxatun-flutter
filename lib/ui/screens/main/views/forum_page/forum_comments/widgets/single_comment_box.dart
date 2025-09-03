import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/create_comment/create_comment_cubit.dart';
import '../../../../../../../cubits/delete_comment/delete_comment_cubit.dart';
import '../../../../../../../cubits/forum_comments/forum_comments_cubit.dart';
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
    this.replies,
    this.parentReplies,
  });

  final Comments comment;
  final ValueNotifier<List<Comments>>? replies;
  final ValueNotifier<List<Comments>>? parentReplies;

  @override
  State<SingleCommentBox> createState() => _SingleCommentBoxState();
}

final ValueNotifier<int> selectedBoxIndex = ValueNotifier<int>(-1);

class _SingleCommentBoxState extends State<SingleCommentBox>
    with AutomaticKeepAliveClientMixin {
  late MainCubit mainCubit;
  late ValueNotifier<bool> hasReplies;
  late CreateCommentCubit createCommentCubit;
  late ForumCommentsCubit forumCommentsCubit;
  late DeleteCommentCubit deleteCommentCubit;
  late List<ValueNotifier<List<Comments>>> replyList;

  @override
  void initState() {
    createCommentCubit = context.read<CreateCommentCubit>();
    forumCommentsCubit = context.read<ForumCommentsCubit>();
    deleteCommentCubit = context.read<DeleteCommentCubit>();
    mainCubit = context.read<MainCubit>();
    hasReplies = ValueNotifier<bool>(widget.replies!.value.isEmpty);
    _initializeReplies();

    super.initState();
  }

  void _initializeReplies() {
    // hasReplies = ValueNotifier<bool>(widget.replies!.value.isEmpty);
    replyList = List.generate(widget.replies!.value.length, (i) {
      return ValueNotifier(widget.replies?.value[i].replies ?? []);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        GestureDetector(
          onLongPressStart: (details) {
            double fromTop = details.globalPosition.dy > 160
                ? details.globalPosition.dy - 160
                : 10;

            mainCubit.showMenuDialogAndEmojis(
              context: context,
              v: fromTop,
              comment: widget.comment,
              replies: widget.replies,
              createCommentCubit: createCommentCubit,
              forumCommentsCubit: forumCommentsCubit,
              deleteCommentCubit: deleteCommentCubit,
            );
            deleteCommentCubit.deletedComment.value = widget.comment;

            selectedBoxIndex.value = widget.index;
          },
          child: ValueListenableBuilder(
            valueListenable: selectedBoxIndex,
            builder: (context, boxIndex, child) {
              return Material(
                shadowColor: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color:
                    widget.index == boxIndex ? Color(0xffFCE4EC) : Colors.white,
                child: child,
              );
            },
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
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: CommentDatas(
                        comment: widget.comment,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SendedReplyBox(
          parentId: widget.comment.id ?? -1,
          parentTag: widget.comment.user?.fullName ?? 'user',
        ),
        BlocListener<DeleteCommentCubit, DeleteCommentState>(
          listener: (context, state) {
            if (state.deleteCommentStatus == DeleteCommentStatus.success) {
              // _initializeReplies();
            }
          },
          child: ValueListenableBuilder(
            valueListenable: hasReplies,
            builder: (context, value, child) {
              return Column(
                children: [
                  Visibility(
                    visible: !value,
                    replacement: ValueListenableBuilder(
                      valueListenable: widget.replies!,
                      builder: (context, replies, child) {
                        log('reply length: ${widget.replies?.value.length}');
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.replies?.value.length,
                          itemBuilder: (_, i) {
                            hasReplies = ValueNotifier<bool>(
                                widget.replies!.value.isEmpty);
                            _initializeReplies();
                            return ReplyBox(
                              key: ValueKey(i),
                              reply: replies[i],
                              boxIndex: i,
                              replies: replyList[i],
                              onTap: () {},
                              parentReplies: widget.replies,
                              parentTag:
                                  widget.comment.user?.fullName ?? 'user',
                            );
                          },
                        );
                      },
                    ),
                    child: TextButton(
                      onPressed: () {
                        hasReplies.value = true;
                      },
                      child: Text(
                        'cavabları göstər',
                        style: TextStyle(color: ColorConstants.primaryRedColor),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
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
