import 'package:burla_xatun/data/models/remote/response/login_response_model.dart';
import 'package:burla_xatun/data/services/remote/base_network_service.dart';
import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';

class LoginService {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final endpoint = EndpointsConstants.login;
    final requestBody = {
      "phone_number": email,
      "password": password,
    };
    final response = await BaseNetwork.instance.getDio().post(
          endpoint,
          data: requestBody,
        );
    if (response.statusCode.isSuccess) {
      return LoginResponseModel.fromJson(response.data);
    } else if (response.statusCode.isFailure) {
      throw Exception("Failed to login");
    }
    throw Exception("Unable to login");
  }

  Future<LoginResponseModel> loginByVideoDoktor({
    required String login,
    required String password,
  }) async {
    final endpoint = EndpointsConstants.videoDoktorLogin;
    final requestBody = {
      "login": login,
      "password": password,
    };
    final response = await BaseNetwork.instance.getDio().post(
          endpoint,
          data: requestBody,
        );
    if (response.statusCode.isSuccess) {
      return LoginResponseModel.fromJson(response.data);
    } else if (response.statusCode.isFailure) {
      throw Exception("Failed to login");
    }
    throw Exception("Unable to login");
  }
}
