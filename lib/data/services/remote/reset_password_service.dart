import 'package:burla_xatun/data/services/remote/base_network_service.dart';
import 'package:burla_xatun/utils/constants/endpoints_constants.dart';
import 'package:dio/dio.dart';

class ResetPasswordService {
  Future<Response<dynamic>> sendCode({
    required String phoneNumber,
  }) async {
    final url = EndpointsConstants.requestResetPassword;

    final postData = {
      "phone_number": phoneNumber,
    };

    final response = await BaseNetwork.instance.post(
      path: url,
      postData: postData,
    );
    return response;
  }

  Future<Response<dynamic>> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    final url = EndpointsConstants.verifyOtp;

    final postData = {
      "phone_number": phoneNumber,
      "otp": otp,
    };

    final response = await BaseNetwork.instance.post(
      path: url,
      postData: postData,
    );
    return response;
  }

  Future<Response<dynamic>> resetPassword({
    required String phoneNumber,
    required String otp,
    required String newPass,
    required String confirmNewPass,
  }) async {
    final url = EndpointsConstants.resetPassword;

    final postData = {
      "phone_number": phoneNumber,
      "otp": otp,
      "new_password": newPass,
      "confirm_password": confirmNewPass,
    };

    final response = await BaseNetwork.instance.post(
      path: url,
      postData: postData,
    );
    return response;
  }
}
