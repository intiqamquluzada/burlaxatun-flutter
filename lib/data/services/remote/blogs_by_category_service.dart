import 'package:burla_xatun/data/services/remote/base_network_service.dart';
import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:dio/dio.dart';

class BlogsByCategoryService {
  Future<Response<dynamic>> getBlogsByCategory({
    required int categoryId,
    String? url,
  }) async {
    
    url ??= '${EndpointsConstants.baseUrl}/extra/blogs/';

    final queryParams = {
      'category': categoryId,
    };

    final response = await BaseNetwork.instance.getDio().get(
          url,
          queryParameters: queryParams,
        );

    return response;
  }
}
