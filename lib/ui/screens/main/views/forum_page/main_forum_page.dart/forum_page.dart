import 'package:flutter/material.dart';

import '../../../../../widgets/global_appbar.dart';
import 'widgets/main_forum_custom_scroll.dart';
 
class MainForumPage extends StatefulWidget {
  const MainForumPage({super.key});

  @override
  State<MainForumPage> createState() => _MainForumPageState();
}

class _MainForumPageState extends State<MainForumPage> {
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
