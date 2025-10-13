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
    String? operationId,
    String? phoneNumber,
    required bool fromRegister,
    required String otp,
  }) {
    return resetPasswordService.verifyOtp(
      operationId: operationId,
      phoneNumber: phoneNumber,
      otp: otp,
      fromRegister: fromRegister,
    );
  }

  @override
  Future<Response> resetPassword({
    required String operationId,
    required String phoneNumber,
    required String newPass,
    required String confirmNewPass,
  }) {
    return resetPasswordService.resetPassword(
      operationId: operationId,
      phoneNumber: phoneNumber,
      newPass: newPass,
      confirmNewPass: confirmNewPass,
    );
  }

  @override
  Future<Response> resendOtp({
    required String phoneNumber,
  }) {
    return resetPasswordService.resendOtp(
      phoneNumber: phoneNumber,
    );
  }
}
