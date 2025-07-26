import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import 'base_network_service.dart';

class ForumListService {
  Future<Response<dynamic>> getForumList({
    int? categoryId,
    String? url,
  }) async {
    String? url;
    // url = nextPage ?? EndpointsConstants.forumList;
    // String url = EndpointsConstants.forumList;
    // final Map<String, dynamic> query = {
    //   'page': page,
    // };
    url ??= EndpointsConstants.forumList;

    final Map<String, dynamic> query = {
      'category': categoryId,
    };

    final response = await BaseNetwork.instance.getDio().get(
          url,
          queryParameters: query,
        );

    return response;
  }
}
