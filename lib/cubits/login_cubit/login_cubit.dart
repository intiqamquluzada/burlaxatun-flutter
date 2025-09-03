import 'dart:developer';

import 'package:burla_xatun/data/contractor/login_contractor.dart';
import 'package:burla_xatun/data/services/local/login_token_service.dart';
import 'package:burla_xatun/utils/di/locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/remote/auth_service.dart';
import 'login_cubit_state.dart';

enum LoginStatus { initial, loading, success, error, networkError }

enum VideoDoktorLoginStatus { initial, loading, success, error, networkError }

class LoginCubit extends Cubit<LoginCubitInitial> {
  LoginCubit(this._contractor) : super(LoginCubitInitial());

  final LoginContractor _contractor;

  final _loginTokenService = locator<LoginTokenService>();

  final loginEmailFocusNode = FocusNode();
  final loginPasswordFocusNode = FocusNode();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  void isObsecureToggle() {
    emit(state.copyWith(isObsecure: !state.isObsecure));
  }

  void updateIsValid() {
    final isActiveButton = loginEmailController.text.trim().isNotEmpty &&
        loginPasswordController.text.trim().isNotEmpty;
    emit(state.copyWith(isActiveButton: isActiveButton));
  }

  void updateVideoDoktorLoginButton({
    required TextEditingController userName,
    required TextEditingController password,
  }) {
    final isActiveButton =
        userName.text.trim().isNotEmpty && password.text.trim().isNotEmpty;
    emit(state.copyWith(isActiveVideoDoktorLoginButton: isActiveButton));
  }

  void disableVideoDoktorButton() {
    emit(state.copyWith(isActiveVideoDoktorLoginButton: false));
  }

  void errorState() {
    emit(state.copyWith(isError: true));
  }

  void errorVideoDoktor() {
    emit(state.copyWith(isVideDoktorError: true));
  }

  void login() async {
    try {
      emit(state.copyWith(loginStatus: LoginStatus.loading, isError: false));
      log("Login Loading");

      final response = await _contractor.login(
        email: loginEmailController.text.trim(),
        password: loginPasswordController.text.trim(),
      );

      await _loginTokenService.saveLoginResponse(response);
      emit(state.copyWith(loginStatus: LoginStatus.success));
      log("Login success");
      log("Saved access token (login): ${_loginTokenService.token}");
    } on DioException catch (e, s) {
      emit(
        state.copyWith(
          loginStatus: LoginStatus.networkError,
          errorMessage:
              (e.response?.data as Map<String, dynamic>)['detail'] ?? '',
        ),
      );
      log("Login Dio Exception: $e", stackTrace: s);
    } catch (e, s) {
      emit(state.copyWith(
        loginStatus: LoginStatus.error,
        errorMessage: '',
      ));
      log("Login Unknown Error: $e", stackTrace: s);
    }
  }

  Future<void> loginByVideoDoktor({
    required String login,
    required String password,
  }) async {
    try {
      emit(state.copyWith(
          videoDoktorLoginStatus: VideoDoktorLoginStatus.loading,
          isVideDoktorError: false));
      log("Login Loading");

      final response = await _contractor.loginByVideoDoktor(
        login: login,
        password: password,
      );

      await _loginTokenService.saveLoginResponse(response);
      emit(state.copyWith(
          videoDoktorLoginStatus: VideoDoktorLoginStatus.success));
      log("video doctor login success");
      log("Saved access token (login): ${_loginTokenService.token}");
    } on DioException catch (e, s) {
      emit(
        state.copyWith(
          videoDoktorLoginStatus: VideoDoktorLoginStatus.networkError,
          errorMessage:
              (e.response?.data as Map<String, dynamic>)['detail'] ?? '',
        ),
      );
      log("Login Dio Exception: $e", stackTrace: s);
    } catch (e, s) {
      emit(state.copyWith(
        videoDoktorLoginStatus: VideoDoktorLoginStatus.error,
        errorMessage: '',
      ));
      log("Login Unknown Error: $e", stackTrace: s);
    }
  }

  @override
  Future<void> close() {
    loginEmailFocusNode.dispose();
    loginPasswordFocusNode.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    return super.close();
  }
}
