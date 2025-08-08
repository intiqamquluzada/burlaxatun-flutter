import 'package:burla_xatun/data/services/local/login_token_service.dart';
import 'package:burla_xatun/utils/di/locator.dart';
import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import 'base_network_service.dart';

class DailyRecService {
  Future<Response<dynamic>> getDailyRec({int? day}) async {
    final endpoint = day == null
        ? EndpointsConstants.myDailyRecommendation
        : '${EndpointsConstants.dailyRecommendationByDay}$day';

    final token = locator<LoginTokenService>().token;

    final response =
        await BaseNetwork.instance.getDio(token: token).get(endpoint);

    return response;
  }
}
