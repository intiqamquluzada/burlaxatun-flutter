import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import '../../../utils/di/locator.dart';
import '../local/login_token_service.dart';
import 'base_network_service.dart';

class TasksByWeekService {
  Future<Response<dynamic>> getTasksByWeek() async {
    const url = '${EndpointsConstants.baseUrl}/B/my-tasks-by-guider/';

    final token = locator<LoginTokenService>().token;

    final response = await BaseNetwork.instance.getDio(token: token).get(url);

    return response;
  }
}
