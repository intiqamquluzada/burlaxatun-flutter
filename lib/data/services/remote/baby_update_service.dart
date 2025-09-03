import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import '../../../utils/di/locator.dart';
import '../local/login_token_service.dart';
import 'base_network_service.dart';

class BabyUpdateService {
  Future<Response<dynamic>> updateBabyData({
    String? name,
    int? height,
    int? weight,
    String? gender,
    String? birthDate,
    bool? haveBorn,
    bool? isFirst,
    bool? haveMiscarriage,
  }) async {
    final url = EndpointsConstants.babyUpdate;
    final data = {};
    if (name != null) data['name'] = name;
    if (weight != null) data['weight'] = weight;
    if (height != null) data['height'] = height;
    if (gender != null) data['gender'] = gender;
    if (birthDate != null) data['birth_date'] = birthDate;
    if (haveBorn != null) data['have_born'] = haveBorn;
    if (isFirst != null) data['is_first'] = isFirst;
    if (haveMiscarriage != null) data['have_miscarriage'] = haveMiscarriage;

    final token = locator<LoginTokenService>().token;

    final response =
        BaseNetwork.instance.getDio(token: token).put(url, data: data);

    return response;
  }
}
