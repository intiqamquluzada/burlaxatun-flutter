import 'package:burla_xatun/data/services/local/login_token_service.dart';
import 'package:burla_xatun/data/services/remote/base_network_service.dart';
import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:burla_xatun/utils/di/locator.dart';
import 'package:dio/dio.dart';

class DeleteCommentService {
  Future<Response<dynamic>> deleteComment({required int commentId}) async {
    final url = '${EndpointsConstants.deleteOrUpdate}/$commentId/';

    final token = locator<LoginTokenService>().token;

    final response =
        await BaseNetwork.instance.getDio(token: token).delete(url);

    return response;
  }
}
