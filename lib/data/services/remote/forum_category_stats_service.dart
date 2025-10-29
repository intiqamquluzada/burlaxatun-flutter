import 'package:burla_xatun/data/services/remote/base_network_service.dart';
import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:dio/dio.dart';

class ForumCategoryStatsService {
  Future<Response<dynamic>> getCategoryStats({String? url}) async {
    url ??= EndpointsConstants.forumCategoryStats;

    final response =
        await BaseNetwork.instance.getDio().get(url, queryParameters: {
      'limit': 4,
    });

    return response;
  }
}
