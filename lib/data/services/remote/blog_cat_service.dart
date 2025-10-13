import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import 'base_network_service.dart';

class BlogCatService {
  Future<Response<dynamic>> getBlogCat({String? search}) async {
    final endpoint = EndpointsConstants.blogCategories;
    Map<String, dynamic> query = {};
    if (search != null) query['search'] = search;

    final response = await BaseNetwork.instance.getDio().get(
          endpoint,
          queryParameters: query,
        );

    return response;
  }
}
