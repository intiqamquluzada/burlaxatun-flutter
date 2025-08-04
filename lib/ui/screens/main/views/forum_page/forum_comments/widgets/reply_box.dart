import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/create_comment/create_comment_cubit.dart';
import '../../../../../../../cubits/delete_comment/delete_comment_cubit.dart';
import '../../../../../../../cubits/forum_comments/forum_comments_cubit.dart';
import '../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../../data/models/remote/response/forum_comments_model.dart';
import '../../../../../../../utils/constants/color_constants.dart';
import 'comment_datas.dart';
import 'sended_reply_box.dart';

class ReplyBox extends StatefulWidget {
  const ReplyBox({
    super.key,
    required this.reply,
    required this.boxIndex,
    this.replies,
    this.onTap,
    required this.parentReplies,
    required this.parentTag,
    this.depthValue,
  });

  final Comments reply;
  final int boxIndex;
  final String parentTag;
  final ValueNotifier<List<Comments>>? replies;
  final ValueNotifier<List<Comments>>? parentReplies;
  final ValueNotifier<int>? depthValue;
  final void Function()? onTap;

  @override
  State<ReplyBox> createState() => _ReplyBoxState();
}

class _ReplyBoxState extends State<ReplyBox> {
  late CreateCommentCubit createCommentCubit;
  late ForumCommentsCubit forumCommentsCubit;
  late MainCubit mainCubit;
  late DeleteCommentCubit deleteCommentCubit;
  late ValueNotifier<bool> showMoreVisible;
  late ValueNotifier<int>? depthValue;
  late List<ValueNotifier<List<Comments>>> replyList;
  // final ValueNotifier<List<Comments>?> sendedReplyToReply =
  //     ValueNotifier<List<Comments>?>(null);
  // final ValueNotifier<Comments?> editedComment = ValueNotifier<Comments?>(null);
  @override
  void initState() {
    createCommentCubit = context.read<CreateCommentCubit>();
    forumCommentsCubit = context.read<ForumCommentsCubit>();
    deleteCommentCubit = context.read<DeleteCommentCubit>();
    mainCubit = context.read<MainCubit>();
    _initializeReplies();

    super.initState();
  }

  void _initializeReplies() {
    if (widget.replies != null) {
      replyList = List.generate(widget.replies!.value.length, (i) {
        return ValueNotifier(widget.replies?.value[i].replies ?? []);
      });
      showMoreVisible = ValueNotifier<bool>(widget.replies!.value.isNotEmpty);
    } else {
      showMoreVisible = ValueNotifier<bool>(false);
    }
  }

  final ValueNotifier<int> selectedReplyBoxIndex = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    if (widget.depthValue == null) {
      depthValue = ValueNotifier<int>(0);
    } else {
      depthValue = ValueNotifier<int>(widget.depthValue!.value);
    }
    _initializeReplies();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.only(left: 35),
        child: GestureDetector(
          onLongPressStart: (details) {
            double fromTop = details.globalPosition.dy > 160
                ? details.globalPosition.dy - 160
                : 10;
            // log('reply valuenotifier list length: ${widget.replies?.value.length}');
            mainCubit.showMenuDialogAndEmojis(
              context: context,
              v: fromTop,
              replies: widget.parentReplies,
              comment: widget.reply,
              createCommentCubit: createCommentCubit,
              forumCommentsCubit: forumCommentsCubit,
              deleteCommentCubit: deleteCommentCubit,
              selectedReplyBoxIndex: selectedReplyBoxIndex,
            );
            selectedReplyBoxIndex.value = widget.boxIndex;
            // replyBoxIndex.value = widget.boxIndex;
          },
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: selectedReplyBoxIndex,
                builder: (context, replyBoxIndex, child) {
                  return Material(
                    shadowColor: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: widget.boxIndex == replyBoxIndex
                        ? Color(0xffFCE4EC)
                        : Colors.white,
                    child: child,
                  );
                },
                child: Ink(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      onTap: widget.onTap,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6.5,
                              horizontal: 10,
                            ),
                            child: CommentDatas(
                              comment: widget.reply,
                              tag: widget.parentTag,
                            ),
                          ),
                          SendedReplyBox(
                            parentId: widget.reply.id!,
                            parentTag: widget.reply.user?.fullName ?? 'user',
                          ),
                          ValueListenableBuilder(
                            valueListenable: showMoreVisible,
                            builder: (context, value, child) {
                              return Column(
                                children: [
                                  Visibility(
                                    visible: value,
                                    replacement: widget.replies != null
                                        ? ValueListenableBuilder(
                                            valueListenable: widget.replies!,
                                            builder: (context, replies, child) {
                                              _initializeReplies();
                                              log('${replies.length}');
                                              return ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: replies.length,
                                                itemBuilder: (_, i) {
                                                  _initializeReplies();
                                                  // final replies =
                                                  //     widget.reply.replies ?? [];
                                                  return ReplyBox(
                                                    depthValue: depthValue,
                                                    reply: replies[i],
                                                    boxIndex: i,
                                                    replies: replyList[i],
                                                    onTap: () {
                                                      // final currentReplies =
                                                      //     List<Comments>.from(
                                                      //         widget.replies!
                                                      //             .value);
                                                      // currentReplies
                                                      //     .remove(replies[i]);
                                                      // widget.replies!.value =
                                                      //     currentReplies;
                                                    },
                                                    parentReplies:
                                                        widget.replies,
                                                    parentTag: widget.reply.user
                                                            ?.fullName ??
                                                        'user',
                                                  );
                                                },
                                              );
                                            },
                                          )
                                        : SizedBox.shrink(),
                                    child: ValueListenableBuilder(
                                      valueListenable: depthValue!,
                                      builder: (context, depth, child) {
                                        return TextButton(
                                          onPressed: () {
                                            showMoreVisible.value = false;
                                            // if (depth == 1) {
                                            //   log('cavablara baxmaga davam et');
                                            //   Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           MultiBlocProvider(
                                            //         providers: [
                                            //           BlocProvider(
                                            //             create: (context) =>
                                            //                 locator<
                                            //                     CreateCommentCubit>(),
                                            //           ),
                                            //           BlocProvider(
                                            //             create: (context) =>
                                            //                 locator<
                                            //                     ForumCommentsCubit>(),
                                            //           ),
                                            //           BlocProvider(
                                            //             create: (context) =>
                                            //                 locator<
                                            //                     DeleteCommentCubit>(),
                                            //           ),
                                            //           BlocProvider(
                                            //             create: (context) =>
                                            //                 locator<
                                            //                     EditCommentCubit>(),
                                            //           ),
                                            //         ],
                                            //         child: ContinueThread(
                                            //           pageContext: context,
                                            //           index: 0,
                                            //           comment: widget.reply,
                                            //           replies: widget.replies,
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   );
                                            // } else {
                                            //   // depthValue!.value += 1;
                                            //   // showMoreVisible.value = false;
                                            // }
                                          },
                                          child: Text(
                                            'show replies',
                                            style: TextStyle(
                                              color: ColorConstants
                                                  .primaryRedColor,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
