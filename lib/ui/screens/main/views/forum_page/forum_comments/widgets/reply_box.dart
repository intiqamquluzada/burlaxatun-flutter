import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/create_comment/create_comment_cubit.dart';
import '../../../../../../../cubits/forum_comments/forum_comments_cubit.dart';
import '../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../../data/models/remote/response/forum_comments_model.dart';
import '../../../../../../../utils/constants/color_constants.dart';
import 'comment_datas.dart';

class ReplyBox extends StatefulWidget {
  const ReplyBox({
    super.key,
    required this.reply,
    required this.boxIndex,
  });

  final Comments reply;
  final int boxIndex;

  @override
  State<ReplyBox> createState() => _ReplyBoxState();
}

class _ReplyBoxState extends State<ReplyBox> {
  late CreateCommentCubit createCommentCubit;
  late ForumCommentsCubit forumCommentsCubit;
  late ValueNotifier<bool> replyeHasReplies;
  final ValueNotifier<int?> replyBoxIndex = ValueNotifier<int?>(null);
  @override
  void initState() {
    createCommentCubit = context.read<CreateCommentCubit>();
    forumCommentsCubit = context.read<ForumCommentsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainnCubit>();
    replyeHasReplies = ValueNotifier<bool>(widget.reply.replies!.isEmpty);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.only(left: 35),
        child: GestureDetector(
          onLongPressStart: (details) {
            double fromTop = details.globalPosition.dy > 160
                ? details.globalPosition.dy - 160
                : 10;

            mainCubit.showMenuDialogAndEmojis(
              context: context,
              v: fromTop,
              comment: widget.reply,
              createCommentCubit: createCommentCubit,
              forumCommentsCubit: forumCommentsCubit,
              replyBoxIndexValue: replyBoxIndex,
            );
            replyBoxIndex.value = widget.boxIndex;
            // mainCubit.updateReplyBoxIndex(widget.boxIndex);
          },
          child: ValueListenableBuilder(
            valueListenable: replyBoxIndex,
            builder: (context, value, child) {
              return Material(
                shadowColor: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color:
                    widget.boxIndex == value ? Color(0xffFCE4EC) : Colors.white,
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
                      onTap: () {},
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6.5,
                              horizontal: 10,
                            ),
                            child: CommentDatas(comment: widget.reply),
                          ),
                          ValueListenableBuilder(
                            valueListenable: replyeHasReplies,
                            builder: (context, value, child) {
                              return Column(
                                children: [
                                  Visibility(
                                    visible: !value,
                                    replacement: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: widget.reply.replies!.length,
                                      itemBuilder: (_, i) {
                                        final replies =
                                            widget.reply.replies ?? [];
                                        return ReplyBox(
                                          reply: replies[i],
                                          boxIndex: i,
                                        );
                                      },
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        replyeHasReplies.value = true;
                                      },
                                      child: Text(
                                        'show replies',
                                        style: TextStyle(
                                          color: ColorConstants.primaryRedColor,
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
        ),
      ),
    );
  }
}
