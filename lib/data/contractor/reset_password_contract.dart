import 'package:dio/dio.dart';

abstract class ResetPasswordContract {
  Future<Response<dynamic>> sendCode({
    required String phoneNumber,
  });

  Future<Response<dynamic>> verifyOtp({
    String? operationId,
    String? phoneNumber,
    required bool fromRegister,
    required String otp,
  });

  Future<Response<dynamic>> resetPassword({
    required String operationId,
    required String phoneNumber,
    required String newPass,
    required String confirmNewPass,
  });

  Future<Response<dynamic>> resendOtp({
    required String phoneNumber,
  });
}
