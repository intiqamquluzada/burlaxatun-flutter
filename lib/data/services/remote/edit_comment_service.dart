import 'package:burla_xatun/data/services/local/login_token_service.dart';
import 'package:burla_xatun/data/services/remote/base_network_service.dart';
import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:burla_xatun/utils/di/locator.dart';
import 'package:dio/dio.dart';

class EditCommentService {
  Future<Response<dynamic>> editComment({
    required int forumId,
    required String text,
    required int? parentId,
    required int commentId,
  }) async {
    final url = '${EndpointsConstants.createComment}$commentId/';
    final token = locator<LoginTokenService>().token;

    final postData = {
      "forum": forumId,
      "text": text,
      "parent": parentId,
    };

    final response = await BaseNetwork.instance.getDio(token: token).put(
          url,
          data: postData,
        );

    return response;
  }
}
