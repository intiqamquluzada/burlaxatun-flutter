import 'package:burla_xatun/data/services/local/login_token_service.dart';
import 'package:burla_xatun/data/services/remote/base_network_service.dart';
import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:burla_xatun/utils/di/locator.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:dio/dio.dart';

class IndicatorService {
  Future<Response<dynamic>> getIndicator({
    int? babyId,
    required String indicatorName,
    required String range,
  }) async {
    const url = EndpointsConstants.babyIndicators;

    final token = locator<LoginTokenService>().token;

    final queryParams = {
      'baby_id': babyId,
      'name': indicatorName,
      'range': range,
    };

    final response = await BaseNetwork.instance.getDio(token: token).get(
          url,
          queryParameters: queryParams,
        );

    if (response.statusCode.isSuccess) {
      return response;
    }
    throw Exception();
  }

  Future<Response<dynamic>> addIndicator({
    required Map<String, dynamic> postData,
  }) async {
    const url = EndpointsConstants.createIndicator;
    final token = locator<LoginTokenService>().token;

    final response = await BaseNetwork.instance
        .getDio(token: token)
        .post(url, data: postData);

    if (response.statusCode.isSuccess) {
      return response;
    }
    throw Exception();
  }
}
