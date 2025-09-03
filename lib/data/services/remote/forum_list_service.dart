import 'package:burla_xatun/data/services/local/login_token_service.dart';
import 'package:burla_xatun/utils/di/locator.dart';
import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import 'base_network_service.dart';

class ForumListService {
  Future<Response<dynamic>> getForumList({
    int? categoryId,
    String? url,
  }) async {
    // String? url;
    // url = nextPage ?? EndpointsConstants.forumList;
    // String url = EndpointsConstants.forumList;
    // final Map<String, dynamic> query = {
    //   'page': page,
    // };

    url ??= EndpointsConstants.forumList;

    // if (url == null) {
    //   url = EndpointsConstants.forumList;
    // } else {

    // }

    final Map<String, dynamic> query = {
      'category': categoryId,
    };

    final token = locator<LoginTokenService>().token;

    final response = await BaseNetwork.instance.getDio(token: token).get(
          url,
          queryParameters: query,
        );

    return response;
  }
}
