import 'package:flutter/material.dart';

import 'comments_box.dart';

class ForumCommentsCustomScroll extends StatelessWidget {
  // final int forumId;

  const ForumCommentsCustomScroll({
    super.key,
    // required this.forumId,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 105),
          sliver: CommentsBox(
            // forumId: forumId,
            // comments: comments,
          ),
        ),
      ],
    );
  }
}
