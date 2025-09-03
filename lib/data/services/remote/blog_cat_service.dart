import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import 'base_network_service.dart';

class BlogCatService {
  Future<Response<dynamic>> getBlogCat() async {
    final endpoint = EndpointsConstants.blogCategories;

    final response = await BaseNetwork.instance.getDio().get(endpoint);

    return response;
  }
}
