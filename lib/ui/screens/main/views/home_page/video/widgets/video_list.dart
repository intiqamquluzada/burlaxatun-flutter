import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/video_cubit/video_cubit.dart';
import '../../../../../../../cubits/video_cubit/video_state.dart';
import '../../../../../../../data/models/remote/response/video_model.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import 'video_box.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late ScrollController scrollController;
  late VideoCubit videoCubit;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
    videoCubit = context.read<VideoCubit>();
    _loadMore();
  }

  void _loadMore() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        log('reach end of scroll');

        await videoCubit.getVideos();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final List<String> url = [
    //   'BK7u4dizImk',
    //   'KZMzgx1-USE',
    //   'pgZv31I3Nww',
    //   '0CcK7GmOyQQ'
    // ];
    return Center(
      child: BlocBuilder<VideoCubit, VideoState>(
        buildWhen: (previous, current) {
          return previous.videos == null || previous.videos!.isEmpty;
        },
        builder: (context, state) {
          if (state.videoStatus == VideoStatus.loading) {
            return CircularProgressIndicator.adaptive();
          } else if (state.videoStatus == VideoStatus.error) {
            return Text('videolar yüklənərkən xəta baş verdi');
          }
          if (state.videoStatus == VideoStatus.success) {
            return Column(
              children: [
                BlocSelector<VideoCubit, VideoState, List<Video>>(
                  selector: (state) {
                    return state.videos ?? [];
                  },
                  builder: (context, videos) {
                    return Expanded(
                      child: ListView.separated(
                        controller: scrollController,
                        itemCount: videos.length,
                        itemBuilder: (_, i) {
                          return VideoBox(
                            videoUrl: videos[i].link,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return 24.h;
                        },
                      ),
                    );
                  },
                ),
                BlocSelector<VideoCubit, VideoState, VideoStatus>(
                  selector: (state) {
                    return state.videoStatus;
                  },
                  builder: (_, status) {
                    return status == VideoStatus.loading
                        ? CircularProgressIndicator.adaptive()
                        : SizedBox.shrink();
                  },
                ),
              ],
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
