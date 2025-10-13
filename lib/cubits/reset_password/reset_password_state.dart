part of 'reset_password_cubit.dart';

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.resetPasswordStatus = ResetPasswordStatus.initial,
    this.phoneNumber,
    this.otp,
    this.sendOtpStatus = SendOtpStatus.initial,
    this.operationId,
  });

  final ResetPasswordStatus resetPasswordStatus;
  final SendOtpStatus sendOtpStatus;
  final String? phoneNumber;
  final String? otp;
  final String? operationId;

  @override
  List<Object?> get props => [
        sendOtpStatus,
        resetPasswordStatus,
        phoneNumber,
        otp,
        operationId,
      ];

  ResetPasswordState copyWith({
    SendOtpStatus? sendOtpStatus,
    ResetPasswordStatus? resetPasswordStatus,
    String? phoneNumber,
    String? otp,
    String? operationId,
  }) {
    return ResetPasswordState(
      sendOtpStatus: sendOtpStatus ?? this.sendOtpStatus,
      resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      operationId: operationId ?? this.operationId,
    );
  }
}
