import 'package:dio/dio.dart';

import '../../../utils/extensions/statuscode_extension.dart';
import 'base_network_service.dart';

class UltrasoundService {
  Future<Response<dynamic>> getUltraSound({required int week}) async {
    final url = 'https://burrla.secop.az/B1/ultra-sound-detail/$week/';

    final response = await BaseNetwork.instance.getDio().get(url);

    if (response.statusCode.isSuccess) {
      return response;
    }
    throw Exception();
  }
}
