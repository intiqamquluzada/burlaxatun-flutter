import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../widgets/global_appbar.dart';
import 'widgets/secondary_forum_page_custom_scroll.dart';

class SecondaryForumPage extends StatelessWidget {
  const SecondaryForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(
        title: 'Forum',
        onLeadingTap: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SecondaryForumPageCustomScroll(),
      ),
    );
  }
}
