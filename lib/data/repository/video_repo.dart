import 'package:dio/src/response.dart';

import '../contractor/video_contract.dart';
import '../services/remote/video_service.dart';

class VideoRepo implements VideoContract {
  VideoRepo(this.videoService);

  final VideoService videoService;

  @override
  Future<Response> getVideos({String? url}) {
    return videoService.getVideos(url: url);
  }
}
