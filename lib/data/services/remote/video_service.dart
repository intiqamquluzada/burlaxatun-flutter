import 'package:burla_xatun/data/services/remote/base_network_service.dart';
import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:dio/dio.dart';

class VideoService {
  Future<Response<dynamic>> getVideos({String? url}) async {
    url ??= '${EndpointsConstants.baseUrl}/extra/videos/';

    final response = await BaseNetwork.instance.getDio().get(url);

    return response;
  }
}
