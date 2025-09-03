import 'package:dio/src/response.dart';

import '../contractor/reset_password_contract.dart';
import '../services/remote/reset_password_service.dart';

class ResetPasswordRepo implements ResetPasswordContract {
  ResetPasswordRepo(this.resetPasswordService);

  final ResetPasswordService resetPasswordService;

  @override
  Future<Response> sendCode({
    required String phoneNumber,
  }) {
    return resetPasswordService.sendCode(phoneNumber: phoneNumber);
  }

  @override
  Future<Response> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) {
    return resetPasswordService.verifyOtp(
      phoneNumber: phoneNumber,
      otp: otp,
    );
  }

  @override
  Future<Response> resetPassword({
    required String phoneNumber,
    required String otp,
    required String newPass,
    required String confirmNewPass,
  }) {
    return resetPasswordService.resetPassword(
      phoneNumber: phoneNumber,
      otp: otp,
      newPass: newPass,
      confirmNewPass: confirmNewPass,
    );
  }
}
