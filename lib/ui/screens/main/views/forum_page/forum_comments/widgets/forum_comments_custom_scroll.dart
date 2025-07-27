import 'package:flutter/material.dart';

import 'comments_box.dart';

class ForumCommentsCustomScroll extends StatelessWidget {
  const ForumCommentsCustomScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 105),
      sliver: CommentsBox(),
    );
  }
}
