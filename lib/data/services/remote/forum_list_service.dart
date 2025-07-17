import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import 'base_network_service.dart';

class ForumListService {
  Future<Response<dynamic>> getForumList({int? page}) async {
    final url = EndpointsConstants.forumList;
    final Map<String, dynamic> query = {
      'page': page,
    };

    final response = await BaseNetwork.instance.getDio().get(
          url,
          queryParameters: query,
        );

    return response;
  }
}
