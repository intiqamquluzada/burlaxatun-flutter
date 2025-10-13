import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:dio/dio.dart';

import '../../../utils/di/locator.dart';
import '../local/login_token_service.dart';
import 'base_network_service.dart';

class NotificationService {
  Future<Response<dynamic>> getNotifications() async {
    final url = '${EndpointsConstants.baseUrl}/notifications/';
    // final url = 'https://burrla.secop.az/notifications/';
    // final url = 'https://anayam.burlaxatun.az/notifications/';

    final accessToken = locator<LoginTokenService>().token;

    final response =
        await BaseNetwork.instance.getDio(token: accessToken).get(url);

    return response;
  }

  Future<Response<dynamic>> saveFcmToken({
    required String fcmToken,
    required String deviceType,
  }) async {
    final url = '${EndpointsConstants.baseUrl}/notifications/fcm-token/';
    // final url = 'https://burrla.secop.az/notifications/fcm-token/';
    final data = {
      "token": fcmToken,
      "device_type": deviceType,
    };
    final token = locator<LoginTokenService>().token;

    final response =
        await BaseNetwork.instance.getDio(token: token).post(url, data: data);

    return response;
  }
}
