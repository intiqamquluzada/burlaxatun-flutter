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
    String? phoneNumber,
    String? operationId,
    required String otp,
    required bool fromRegister,
  }) async {
    final url = fromRegister
        ? EndpointsConstants.registerVerifyOtp
        : EndpointsConstants.resetPasswordVerifyOtp;

    final Map<String, dynamic> postData = {};

    if (fromRegister) {
      postData["phone_number"] = phoneNumber;
      postData["otp_code"] = otp;
    } else {
      postData["operation_id"] = operationId;
      postData["code"] = otp;
    }

    final response = await BaseNetwork.instance.post(
      path: url,
      postData: postData,
    );
    return response;
  }

  Future<Response<dynamic>> resetPassword({
    required String operationId,
    required String phoneNumber,
    required String newPass,
    required String confirmNewPass,
  }) async {
    final url = EndpointsConstants.resetPassword;

    final postData = {
      "operation_id": operationId,
      "phone_number": phoneNumber,
      "password": newPass,
      "password2": confirmNewPass,
    };

    final response = await BaseNetwork.instance.post(
      path: url,
      postData: postData,
    );
    return response;
  }

  Future<Response<dynamic>> resendOtp({required String phoneNumber}) async {
    final url = EndpointsConstants.resendOtp;

    final postData = {
      'phone_number': phoneNumber,
    };

    final response = await BaseNetwork.instance.post(
      path: url,
      postData: postData,
    );

    return response;
  }
}
