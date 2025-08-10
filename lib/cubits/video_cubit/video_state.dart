import 'package:burla_xatun/cubits/video_cubit/video_cubit.dart';
import 'package:burla_xatun/data/models/remote/response/video_model.dart';
import 'package:equatable/equatable.dart';

class VideoState extends Equatable {
  const VideoState({
    this.videoStatus = VideoStatus.initial,
    this.videos,
  });

  final VideoStatus videoStatus;
  final List<Video>? videos;

  @override
  List<Object?> get props => [
        videoStatus,
        videos,
      ];

  VideoState copyWith({
    VideoStatus? videoStatus,
    List<Video>? videos,
  }) {
    return VideoState(
      videoStatus: videoStatus ?? this.videoStatus,
      videos: videos ?? this.videos,
    );
  }
}
