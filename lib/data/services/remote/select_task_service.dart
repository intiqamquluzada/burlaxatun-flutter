import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import '../../../utils/di/locator.dart';
import '../local/login_token_service.dart';
import 'base_network_service.dart';

class SelectTaskService {
  Future<Response<dynamic>> selectTask({required int taskId}) async {
    final selectUrl = '${EndpointsConstants.baseUrl}/B/task-by-guider/select/';

    final data = {
      'task': taskId,
    };

    final token = locator<LoginTokenService>().token;

    final response = await BaseNetwork.instance
        .getDio(token: token)
        .post(selectUrl, data: data);

    return response;
  }

  Future<Response<dynamic>> declineTask({required int taskId}) async {
    final deleteUrl =
        '${EndpointsConstants.baseUrl}/B/task-by-guider/decline/$taskId/';

    final token = locator<LoginTokenService>().token;

    final response =
        await BaseNetwork.instance.getDio(token: token).delete(deleteUrl);

    return response;
  }
}
