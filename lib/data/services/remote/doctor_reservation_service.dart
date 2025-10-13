import 'package:burla_xatun/data/services/local/login_token_service.dart';
import 'package:burla_xatun/data/services/remote/base_network_service.dart';
import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:burla_xatun/utils/di/locator.dart';
import 'package:dio/dio.dart';

class DoctorReservationService {
  Future<Response<dynamic>> reserveDoctor({
    required int schedulingTimeId,
  }) async {
    final url =
        '${EndpointsConstants.baseUrl}/C/doctors/scheduling-item-record/';
    final token = locator<LoginTokenService>().token;

    final postData = {
      'scheduling_item_id': schedulingTimeId,
    };

    final response = await BaseNetwork.instance
        .getDio(token: token)
        .post(url, data: postData);

    return response;
  }
}
