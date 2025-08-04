import 'package:dio/dio.dart';

import '../../../utils/di/locator.dart';
import '../local/login_token_service.dart';
import 'base_network_service.dart';

class TasksByWeekService {
  Future<Response<dynamic>> getTasksByWeek() async {
    const url = 'https://burrla.secop.az/B/my-tasks-by-guider/';

    final token = locator<LoginTokenService>().token;

    final response = await BaseNetwork.instance.getDio(token: token).get(url);

    return response;
  }
}
