import 'package:dio/dio.dart';

import '../../../utils/di/locator.dart';
import '../local/login_token_service.dart';
import 'base_network_service.dart';

class CreateForumService {
  Future<Response<dynamic>> createForum({
    required int categoryId,
    required String text,
  }) async {
    final url = 'https://burrla.secop.az/D/forum-create/';

    final postData = {
      "category_id": categoryId,
      "text": text,
    };

    final token = locator<LoginTokenService>().token;

    final response = await BaseNetwork.instance
        .getDio(token: token)
        .post(url, data: postData);

    return response;
  }
}
