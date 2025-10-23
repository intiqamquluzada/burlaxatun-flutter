import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../widgets/global_appbar.dart';
import 'widgets/video_list.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: GlobalAppbar(
        title: 'Video',
        onLeadingTap: () {
          context.pop();
        },
      ),
      body: VideoList(),
    );
  }
}
