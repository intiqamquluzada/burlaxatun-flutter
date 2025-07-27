import 'package:flutter/material.dart';

import '../../../../../../../data/models/remote/response/forum_comments_model.dart';
import '../../../../../../../utils/constants/color_constants.dart';
import 'comment_datas.dart';

class ReplyBox extends StatelessWidget {
  const ReplyBox({
    super.key,
    required this.reply,
  });

  final Comments reply;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> replyeHasReplies =
        ValueNotifier<bool>(reply.replies!.isEmpty);
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
                      child: CommentDatas(comment: reply),
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
                                itemCount: reply.replies!.length,
                                itemBuilder: (_, i) {
                                  final replies = reply.replies ?? [];
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
