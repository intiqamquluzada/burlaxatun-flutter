import 'package:flutter/material.dart';

import 'single_comment_box.dart';

class CommentsBox extends StatelessWidget {
  const CommentsBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(width: 2, color: Color(0xffE4E7EC)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, i) {
            return SingleCommentBox(i: i);
          },
        ),
      ),
    );
  }
}
