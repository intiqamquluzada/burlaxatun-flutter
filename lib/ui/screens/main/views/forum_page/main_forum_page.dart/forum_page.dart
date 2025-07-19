import 'package:flutter/material.dart';

import '../../../../../widgets/global_appbar.dart';
import 'widgets/main_forum_custom_scroll.dart';

class MainForumPage extends StatelessWidget {
  const MainForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GlobalAppbar(
        title: 'Əsas forum',
        leading: SizedBox(),
      ),
      body: MainForumCustomScroll(),
    );
  }
}
