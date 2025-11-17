import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:dio/dio.dart';

import '../../../utils/extensions/statuscode_extension.dart';
import 'base_network_service.dart';

class UltrasoundService {
  Future<Response<dynamic>> getUltraSound({required int week}) async {
    final url = '${EndpointsConstants.ultraSoundDetail}/$week';

    final response = await BaseNetwork.instance.getDio().get(url);

    if (response.statusCode.isSuccess) {
      return response;
    }
    throw Exception();
  }
}
