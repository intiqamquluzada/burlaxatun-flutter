import 'dart:developer';

import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:dio/dio.dart';

import '../../../utils/constants/endpoints_constants.dart';
import '../../../utils/di/locator.dart';
import '../local/login_token_service.dart';
import 'base_network_service.dart';

class ChangePassService {
  final endpoint = EndpointsConstants.changePassword;

  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword1,
    required String newPassword2,
  }) async {
    final token = locator<LoginTokenService>().token;

    final requestBody = {
      "old_password": oldPassword,
      "new_password1": newPassword1,
      "new_password2": newPassword2,
    };


    final response = await BaseNetwork.instance.post(
      path: endpoint,
      postData: requestBody,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    log('Change password  response: ${response.data}');

    return response.statusCode.isSuccess;
  }
}
