import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import 'base_network_service.dart';

class ForumCategoryService {
  Future<Response> getForumCategory({String? url}) async {
    log('url as parameter: $url');
    url ??= EndpointsConstants.forumCategory;
    log('request url: $url');
    final response =
        await BaseNetwork.instance.getDio().get(url, queryParameters: {
      'limit': 4,
    });

    return response;
    //   if (response.statusCode.isSuccess) {
    //     final data = ForumCategoryModel.fromJson(response.data);
    //     return data.results ?? [];
    //   } else if (response.statusCode.isFailure) {
    //     throw Exception("Failed to load forum category");
    //   }
    //   throw Exception("Unable to get forum category data");
    // }
  }
}
