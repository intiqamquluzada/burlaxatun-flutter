import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import '../../../utils/di/locator.dart';
import '../local/login_token_service.dart';
import 'base_network_service.dart';

class PregnancyProgressService {
  Future<Response<dynamic>> getPregnancyProgress({required String date}) async {
    final url = EndpointsConstants.progressPregnancyByDate;

    final query = {
      'date': date,
    };

    final token = locator<LoginTokenService>().token;

    final response = await BaseNetwork.instance.getDio(token: token).get(
          url,
          queryParameters: query,
        );

    return response;
  }
}
