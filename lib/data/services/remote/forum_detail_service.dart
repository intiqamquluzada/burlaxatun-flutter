import 'package:burla_xatun/data/services/remote/base_network_service.dart';
import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:dio/dio.dart';

class ForumDetailService {
  Future<Response<dynamic>> getForumDetail({required int postId}) async {
    final url = EndpointsConstants.postDetail;

    final Map<String, dynamic> queryParams = {
      'id': postId,
    };

    final response =
        BaseNetwork.instance.getDio().get(url, queryParameters: queryParams);

    return response;
  }
}
