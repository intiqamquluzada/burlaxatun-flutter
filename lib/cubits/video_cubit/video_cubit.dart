import 'dart:developer';

import 'package:burla_xatun/data/models/remote/response/video_model.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/video_contract.dart';
import 'video_state.dart';

enum VideoStatus { initial, loading, error, success, networkError }

class VideoCubit extends Cubit<VideoState> {
  VideoCubit(this.videoContract) : super(VideoState());

  final VideoContract videoContract;

  List<Video> videos = [];
  String? url = '';

  Future<void> getVideos({bool isRefresh = false}) async {
    if (isRefresh) {
      videos = [];
      url = isRefresh ? '' : url;
      emit(state.copyWith(videos: []));
    }
    if (url == null || state.videoStatus == VideoStatus.loading) {
      return;
    }
    try {
      emit(state.copyWith(videoStatus: VideoStatus.loading));
      final response = await videoContract.getVideos(
        url: url!.isEmpty ? null : url,
      );

      if (!response.statusCode.isSuccess) return;

      final data = VideoModel.fromJson(response.data);

      url = data.next;

      data.results?.forEach((e) {
        videos.add(e);
      });

      emit(state.copyWith(
        videoStatus: VideoStatus.success,
        videos: List.from(videos),
      ));
    } catch (e, s) {
      log('Error occured while getting videos: $e', stackTrace: s);
      emit(state.copyWith(videoStatus: VideoStatus.error));
    }
  }
}
