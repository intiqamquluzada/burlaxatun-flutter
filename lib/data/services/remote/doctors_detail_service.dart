import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import '../../../utils/di/locator.dart';
import '../local/login_token_service.dart';
import 'base_network_service.dart';

class DoctorDetailService {
  final token = locator<LoginTokenService>().token;

  Future<Response> getDoctorDetail({required int doctorId}) async {
    final url = '${EndpointsConstants.doctorDetails}/$doctorId/';

    final response = await BaseNetwork.instance.getDio(token: token).get(url);

    return response;
  }

  Future<Response> getAvailableTimes({
    required String date,
    required int doctorId,
  }) async {
    final url = '${EndpointsConstants.baseUrl}/C/doctors/scheduling-items/';

    final queryParams = {
      'date_from': date,
      'doctor_id': doctorId,
    };

    final response = await BaseNetwork.instance
        .getDio(token: token)
        .get(url, queryParameters: queryParams);

    return response;
  }
}
