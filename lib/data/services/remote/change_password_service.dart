import 'package:burla_xatun/data/services/local/login_token_service.dart';
import 'package:burla_xatun/data/services/remote/base_network_service.dart';
import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:burla_xatun/utils/di/locator.dart';
import 'package:dio/dio.dart';

class ChangePasswordService {
  Future<Response<dynamic>> changePassword({
    required String oldPassword,
    required String newPassword1,
    required String newPassword2,
  }) async {
    final url = EndpointsConstants.changePassword;

    final postData = {
      "old_password": oldPassword,
      "new_password1": newPassword1,
      "new_password2": newPassword2
    };

    final token = locator<LoginTokenService>().token;

    final response = await BaseNetwork.instance
        .getDio(token: token)
        .post(url, data: postData);
    return response;
  }
}
