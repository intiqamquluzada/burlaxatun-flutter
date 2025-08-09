import 'package:burla_xatun/data/models/remote/response/blog_category_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'widgets/article_detail.dart';
import 'widgets/article_details_appbar.dart';

class ArticleDetailsPage extends StatefulWidget {
  final BlogModel blog;

  const ArticleDetailsPage({
    super.key,
    required this.blog,
  });

  @override
  State<ArticleDetailsPage> createState() => _ArticleDetailsPageState();
}

class _ArticleDetailsPageState extends State<ArticleDetailsPage> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;

  bool get isVideo {
    final url = widget.blog.file?.toLowerCase();
    return url != null &&
        (url.endsWith('.mp4') ||
            url.endsWith('.mov') ||
            url.endsWith('.avi') ||
            url.endsWith('.mkv'));
  }

  @override
  void initState() {
    super.initState();
    if (isVideo) {
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.blog.file!))
            ..initialize().then((_) {
              setState(() {});
            });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _handlePlayPause() {
    if (_controller == null) return;

    if (_isPlaying) {
      _controller!.pause();
    } else {
      _controller!.play();
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArticleDetailsAppbar(
        imagePath: widget.blog.file ?? '',
        isVideo: isVideo,
        videoController: _controller,
        isPlaying: _isPlaying,
        onPlayPause: _handlePlayPause,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: ArticleDetail(
                title: widget.blog.name ?? '',
                text: widget.blog.text ?? '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
