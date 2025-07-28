import 'package:burla_xatun/data/services/remote/base_network_service.dart';
import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:dio/dio.dart';

class ForumCommentService {
  Future<Response<dynamic>> getForumComments({
    required int forumId,
    String? url,
  }) async {
    // final url = '${EndpointsConstants.forumComments}/$forumId';
    url ??= '${EndpointsConstants.forumComments}/$forumId';

    final response = await BaseNetwork.instance.getDio().get(url);

    return response;
  }
}
 