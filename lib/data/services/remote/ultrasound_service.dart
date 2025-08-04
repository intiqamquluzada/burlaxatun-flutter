import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import '../../../utils/extensions/statuscode_extension.dart';
import 'base_network_service.dart';

class UltrasoundService {
  Future<Response<dynamic>> getUltraSound() async {
    final url = EndpointsConstants.ultraSound;

    final response = await BaseNetwork.instance.getDio().get(url);

    if (response.statusCode.isSuccess) {
      return response;
    }
    throw Exception();
  }
}
