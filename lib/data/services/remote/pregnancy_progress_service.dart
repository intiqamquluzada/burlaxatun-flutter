import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import '../../../utils/di/locator.dart';
import '../local/login_token_service.dart';
import 'base_network_service.dart';

class PregnancyProgressService {
  Future<Response<dynamic>> getPregnancyProgress() async {
    final url = EndpointsConstants.progressPregnancy;

    // final query = {
    //   'week': week,
    // };

    final token = locator<LoginTokenService>().token;

    final response = await BaseNetwork.instance.getDio(token: token).get(url);

    return response;
  }
}
