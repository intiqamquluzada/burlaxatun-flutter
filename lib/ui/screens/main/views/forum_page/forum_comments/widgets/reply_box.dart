import 'dart:developer';

import 'package:burla_xatun/cubits/delete_comment/delete_comment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/create_comment/create_comment_cubit.dart';
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
  });

  final Comments reply;
  final int boxIndex;
  final ValueNotifier<List<Comments>>? replies;
  final ValueNotifier<List<Comments>>? parentReplies;
  final void Function()? onTap;

  @override
  State<ReplyBox> createState() => _ReplyBoxState();
}

class _ReplyBoxState extends State<ReplyBox> {
  late CreateCommentCubit createCommentCubit;
  late ForumCommentsCubit forumCommentsCubit;
  late DeleteCommentCubit deleteCommentCubit;
  late ValueNotifier<bool> showMoreVisible;
  final ValueNotifier<int?> replyBoxIndex = ValueNotifier<int?>(null);
  late List<ValueNotifier<List<Comments>>> replyList;
  // final ValueNotifier<List<Comments>?> sendedReplyToReply =
  //     ValueNotifier<List<Comments>?>(null);
  // final ValueNotifier<Comments?> editedComment = ValueNotifier<Comments?>(null);
  @override
  void initState() {
    createCommentCubit = context.read<CreateCommentCubit>();
    forumCommentsCubit = context.read<ForumCommentsCubit>();
    deleteCommentCubit = context.read<DeleteCommentCubit>();
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

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainnCubit>();
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
            log('reply valuenotifier list length: ${widget.replies?.value.length}');
            mainCubit.showMenuDialogAndEmojis(
              context: context,
              v: fromTop,
              replies: widget.parentReplies,
              comment: widget.reply,
              createCommentCubit: createCommentCubit,
              forumCommentsCubit: forumCommentsCubit,
              replyBoxIndexValue: replyBoxIndex,
              deleteCommentCubit: deleteCommentCubit,
            );
            replyBoxIndex.value = widget.boxIndex;
          },
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: replyBoxIndex,
                builder: (context, value, child) {
                  return Material(
                    shadowColor: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: widget.boxIndex == value
                        ? Color(0xffFCE4EC)
                        : Colors.white,
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
                                child: CommentDatas(comment: widget.reply),
                              ),
                              SendedReplyBox(parentId: widget.reply.id!),
                              ValueListenableBuilder(
                                valueListenable: showMoreVisible,
                                builder: (context, value, child) {
                                  return Column(
                                    children: [
                                      Visibility(
                                        visible: value,
                                        replacement: widget.replies != null
                                            ? ValueListenableBuilder(
                                                valueListenable:
                                                    widget.replies!,
                                                builder:
                                                    (context, replies, child) {
                                                  return ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: replies.length,
                                                    itemBuilder: (_, i) {
                                                      // final replies =
                                                      //     widget.reply.replies ?? [];
                                                      return ReplyBox(
                                                        reply: replies[i],
                                                        boxIndex: i,
                                                        replies: replyList[i],
                                                        onTap: () {
                                                          final currentReplies =
                                                              List<Comments>.from(
                                                                  widget
                                                                      .replies!
                                                                      .value);
                                                          currentReplies.remove(
                                                              replies[i]);
                                                          widget.replies!
                                                                  .value =
                                                              currentReplies;
                                                        },
                                                        parentReplies:
                                                            widget.replies,
                                                      );
                                                    },
                                                  );
                                                },
                                              )
                                            : SizedBox.shrink(),
                                        child: TextButton(
                                          onPressed: () {
                                            showMoreVisible.value = false;
                                          },
                                          child: Text(
                                            'show replies',
                                            style: TextStyle(
                                              color: ColorConstants
                                                  .primaryRedColor,
                                            ),
                                          ),
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
