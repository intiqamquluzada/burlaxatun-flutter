import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import '../../../utils/di/locator.dart';
import '../local/login_token_service.dart';
import 'base_network_service.dart';

class CreateCommentService {
  Future<Response<dynamic>> sendComment({
    required int forumId,
    required String text,
    required int? parentId,
  }) async {
    final url = EndpointsConstants.createComment;
    final token = locator<LoginTokenService>().token;

    final postData = {
      "forum": forumId,
      "text": text,
      "parent": parentId,
    };

    final response = await BaseNetwork.instance
        .getDio(token: token)
        .post(url, data: postData);

    return response;
  }
}
