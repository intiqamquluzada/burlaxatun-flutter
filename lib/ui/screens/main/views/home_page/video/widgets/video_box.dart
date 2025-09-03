import 'package:flutter/material.dart';
import 'package:flutter_youtube_video/flutter_youtube_video.dart';

import '../../widgets/article_box.dart';

class VideoBox extends StatefulWidget {
  const VideoBox({
    super.key,
    this.videoUrl,
    this.title,
  });

  final String? videoUrl;
  final String? title;

  @override
  State<VideoBox> createState() => _VideoBoxState();
}

class _VideoBoxState extends State<VideoBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final id = extractId(widget.videoUrl);

    return ArticleBox(
      videoOrImage: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: AspectRatio(
                aspectRatio: 16 / 9.1,
                child: FlutterYoutubePlayer(videoId: id),
              ),
            ),
          ),
        ],
      ),
      boxTitle: widget.title ?? 'Başlıq tapılmadı',
      boxDescription: '',
    );
  }

  String extractId(String? videoUrl) {
    final uri = Uri.parse(videoUrl ?? '');

    if (uri.queryParameters.containsKey('v')) {
      return uri.queryParameters['v']!;
    } else if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.first;
    } else if (uri.pathSegments.contains('embed')) {
      return uri.pathSegments[1];
    } else {
      return '';
    }
  }
}
