import 'package:burla_xatun/data/services/local/login_token_service.dart';
import 'package:burla_xatun/data/services/remote/base_network_service.dart';
import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:burla_xatun/utils/di/locator.dart';
import 'package:dio/dio.dart';

class ReportOrBlockService {
  Future<Response<dynamic>> reportComment({required int commentId}) async {
    final url = EndpointsConstants.reportComment;
    final postData = {
      'comment': commentId,
    };
    final token = locator<LoginTokenService>().token;
    final response = await BaseNetwork.instance.getDio(token: token).post(
          url,
          data: postData,
        );

    return response;
  }

  Future<Response<dynamic>> blockUser({required int userId}) async {
    final url = EndpointsConstants.blockUser;
    final postData = {
      'blocked_user': userId,
    };
    final token = locator<LoginTokenService>().token;
    final response = await BaseNetwork.instance.getDio(token: token).post(
          url,
          data: postData,
        );

    return response;
  }

  Future<Response<dynamic>> reportForum({required int forumId}) async {
    final url = EndpointsConstants.reportForum;

    final postData = {
      'forum': forumId,
    };

    final token = locator<LoginTokenService>().token;
    final response = await BaseNetwork.instance
        .getDio(token: token)
        .post(url, data: postData);

    return response;
  }

  Future<Response<dynamic>> blockForum({required int forumId}) async {
    final url = EndpointsConstants.blockForum;

    final postData = {
      'forum': forumId,
    };

    final token = locator<LoginTokenService>().token;
    final response = await BaseNetwork.instance
        .getDio(token: token)
        .post(url, data: postData);

    return response;
  }
}
