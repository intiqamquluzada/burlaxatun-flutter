import 'dart:developer';

import 'package:burla_xatun/data/contractor/reset_password_contract.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'reset_password_state.dart';

enum SendOtpStatus { initial, error, success, sendAgainSuccess, loading }

enum ResetPasswordStatus { initial, error, success, loading }

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this.resetPasswordContract) : super(ResetPasswordState());

  final ResetPasswordContract resetPasswordContract;

  Future<void> sendCode({String? phoneNumber}) async {
    try {
      emit(state.copyWith(sendOtpStatus: SendOtpStatus.loading));
      final response = await resetPasswordContract.sendCode(
        phoneNumber: phoneNumber ?? state.phoneNumber!,
      );

      if (!response.statusCode.isSuccess) return;

      final Map<String, dynamic> operationData =
          (response.data as Map<String, dynamic>)['operation_data'];

      log('operation id: ${operationData['operation']}');

      emit(state.copyWith(
        sendOtpStatus: SendOtpStatus.success,
        phoneNumber: phoneNumber,
        operationId: operationData['operation'],
      ));
    } catch (e, s) {
      log('Error occured while sending code to number: $e', stackTrace: s);
      emit(state.copyWith(sendOtpStatus: SendOtpStatus.error));
    }
  }

  Future<void> confirmOtp({
    required String otp,
    required bool fromRegister,
    String? phoneNumber,
  }) async {
    log('opeartion id in state ${state.operationId}');
    try {
      emit(state.copyWith(resetPasswordStatus: ResetPasswordStatus.loading));
      final response = await resetPasswordContract.verifyOtp(
        phoneNumber: phoneNumber,
        operationId: state.operationId,
        otp: otp,
        fromRegister: fromRegister,
      );
      if (!response.statusCode.isSuccess) return;
      emit(state.copyWith(
        resetPasswordStatus: ResetPasswordStatus.success,
        otp: otp,
      ));
    } catch (e, s) {
      log('Error occured while confirming otp code: $e', stackTrace: s);
      emit(state.copyWith(resetPasswordStatus: ResetPasswordStatus.error));
    }
  }

  // Future<void> registerVerifyOtp() {}

  Future<void> resetPassword({
    required String newPass,
    required String confirmNewPass,
  }) async {
    try {
      emit(state.copyWith(resetPasswordStatus: ResetPasswordStatus.loading));
      final response = await resetPasswordContract.resetPassword(
        phoneNumber: state.phoneNumber ?? '',
        operationId: state.operationId ?? '',
        newPass: newPass,
        confirmNewPass: confirmNewPass,
      );

      if (!response.statusCode.isSuccess) return;
      emit(state.copyWith(resetPasswordStatus: ResetPasswordStatus.success));
    } catch (e, s) {
      log('Error occured while reseting password: $e', stackTrace: s);
      emit(state.copyWith(resetPasswordStatus: ResetPasswordStatus.error));
    }
  }

  Future<void> resendOtp({required String phoneNumber}) async {
    try {
      emit(state.copyWith(sendOtpStatus: SendOtpStatus.loading));
      final response =
          await resetPasswordContract.resendOtp(phoneNumber: phoneNumber);

      if (!response.statusCode.isSuccess) return;
      emit(state.copyWith(sendOtpStatus: SendOtpStatus.success));
    } catch (e, s) {
      log('Error occured while resending otp to number: $e', stackTrace: s);
      emit(state.copyWith(sendOtpStatus: SendOtpStatus.error));
    }
  }
}
