import 'package:flutter/material.dart';

import '../../../../../../../data/models/remote/response/forum_comments_model.dart';
import '../../../../../../../utils/constants/color_constants.dart';
import 'comment_datas.dart';

class ReplyBox extends StatefulWidget {
  const ReplyBox({
    super.key,
    required this.reply,
  });

  final Comments reply;

  @override
  State<ReplyBox> createState() => _ReplyBoxState();
}

class _ReplyBoxState extends State<ReplyBox> {
  late ValueNotifier<bool> replyeHasReplies;
  @override
  void initState() {
    replyeHasReplies = ValueNotifier<bool>(widget.reply.replies!.isEmpty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: SizedBox(
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
                                  final replies = widget.reply.replies ?? [];
                                  return ReplyBox(
                                    reply: replies[i],
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
        ),
      ),
    );
  }
}
