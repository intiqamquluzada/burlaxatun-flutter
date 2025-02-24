import 'package:flutter/material.dart';

import '../../widgets/forum_box.dart';
import 'comments_box.dart';

class ForumCommentsCustomScroll extends StatelessWidget {
  const ForumCommentsCustomScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 24),
          sliver: SliverToBoxAdapter(
            child: ForumBox(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 105),
            child: CommentsBox(),
          ),
        ),
      ],
    );
  }
}
