import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import 'base_network_service.dart';

class DailyRecService {
  Future<Response<dynamic>> getDailyRec() async {
    final endpoint = EndpointsConstants.dailyRec;

    final response = await BaseNetwork.instance.getDio().get(endpoint);

    return response;
  }
}
