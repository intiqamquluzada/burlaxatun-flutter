import 'package:burla_xatun/cubits/login_cubit/login_cubit.dart';
import 'package:equatable/equatable.dart';

class LoginCubitInitial extends Equatable {
  const LoginCubitInitial({
    this.isActiveButton = false,
    this.isObsecure = true,
    this.isError = false,
    this.isVideDoktorError = false,
    this.loginStatus = LoginStatus.initial,
    this.errorMessage,
    this.videoDoktorLoginStatus = VideoDoktorLoginStatus.initial,
    this.isActiveVideoDoktorLoginButton = false,
    this.questionCompleted,
    this.errorCode,
  });

  final bool isActiveButton;
  final bool isObsecure;
  final bool isError;
  final bool isVideDoktorError;
  final bool isActiveVideoDoktorLoginButton;
  final LoginStatus loginStatus;
  final VideoDoktorLoginStatus videoDoktorLoginStatus;
  final String? errorMessage;
  final bool? questionCompleted;
  final String? errorCode;

  @override
  List<Object?> get props => [
        isActiveButton,
        isObsecure,
        isError,
        loginStatus,
        errorMessage,
        videoDoktorLoginStatus,
        isVideDoktorError,
        isActiveVideoDoktorLoginButton,
        questionCompleted,
        errorCode,
      ];

  LoginCubitInitial copyWith({
    bool? isActiveButton,
    bool? isObsecure,
    bool? isError,
    LoginStatus? loginStatus,
    String? errorMessage,
    VideoDoktorLoginStatus? videoDoktorLoginStatus,
    bool? isVideDoktorError,
    bool? isActiveVideoDoktorLoginButton,
    bool? questionCompleted,
    String? errorCode,
  }) {
    return LoginCubitInitial(
      isVideDoktorError: isVideDoktorError ?? this.isVideDoktorError,
      isActiveButton: isActiveButton ?? this.isActiveButton,
      isObsecure: isObsecure ?? this.isObsecure,
      isError: isError ?? this.isError,
      loginStatus: loginStatus ?? this.loginStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      videoDoktorLoginStatus:
          videoDoktorLoginStatus ?? this.videoDoktorLoginStatus,
      isActiveVideoDoktorLoginButton:
          isActiveVideoDoktorLoginButton ?? this.isActiveVideoDoktorLoginButton,
      questionCompleted: questionCompleted ?? this.questionCompleted,
      errorCode: errorCode ?? this.errorCode,
    );
  }
}
