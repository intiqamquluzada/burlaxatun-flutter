import 'package:burla_xatun/data/services/remote/base_network_service.dart';
import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:dio/dio.dart';

class ForumDetailService {
  Future<Response<dynamic>> getForumDetail({required String forumSlug}) async {
    final url = '${EndpointsConstants.forumDetail}/$forumSlug';

    // final Map<String, dynamic> queryParams = {
    //   'id': ,
    // };

    final response = BaseNetwork.instance.getDio().get(url);

    return response;
  }
}
