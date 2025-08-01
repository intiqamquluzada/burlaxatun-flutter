import 'package:burla_xatun/data/services/local/login_token_service.dart';
import 'package:burla_xatun/data/services/local/token_hive_service.dart';
import 'package:burla_xatun/data/services/remote/base_network_service.dart';
import 'package:burla_xatun/utils/di/locator.dart';
import 'package:dio/dio.dart';

class CreateForumService {
  Future<Response<dynamic>> createForum({
    required int categoryId,
    required String text,
  }) async {
    final url = 'https://burrla.secop.az/D/forum-create/';

    final postData = {
      "category": categoryId,
      "text": text,
    };

    final token = locator<LoginTokenService>().token;

    final response = await BaseNetwork.instance
        .getDio(token: token)
        .post(url, data: postData);

    return response;
  }
}
