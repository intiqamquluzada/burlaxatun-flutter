import 'package:dio/dio.dart';

abstract class VideoContract {
  Future<Response<dynamic>> getVideos({String? url});
}
