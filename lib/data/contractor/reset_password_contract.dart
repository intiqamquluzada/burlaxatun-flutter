import 'package:dio/dio.dart';

abstract class ResetPasswordContract {
  Future<Response<dynamic>> sendCode({
    required String phoneNumber,
  });

  Future<Response<dynamic>> verifyOtp({
    required String phoneNumber,
    required String otp,
  });

  Future<Response<dynamic>> resetPassword({
    required String phoneNumber,
    required String otp,
    required String newPass,
    required String confirmNewPass,
  });
}
