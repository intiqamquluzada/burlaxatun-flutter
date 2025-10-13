import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import '../../../utils/di/locator.dart';
import '../local/login_token_service.dart';
import 'base_network_service.dart';

class DoctorsListService {
  final token = locator<LoginTokenService>().token;
  Future<Response> getSpecializations({String? url}) async {
    url ??= EndpointsConstants.doctorSpecialities;

    final response = await BaseNetwork.instance.getDio(token: token).get(url);

    return response;
  }

  Future<Response> getDoctorsList({
    int? specializationId,
    String? url,
    String? search,
  }) async {
    // String url = '';
    // if (specializationId == null) {
    //   url = next!;
    // } else {
    //   url = '${EndpointsConstants.doctorsList}/$specializationId/';
    // }
    url ??= '${EndpointsConstants.doctorsList}/$specializationId/';

    final queryParam = {
      'search': search,
    };

    final response = await BaseNetwork.instance.getDio(token: token).get(
          url,
          queryParameters: queryParam,
        );

    return response;
  }
}
