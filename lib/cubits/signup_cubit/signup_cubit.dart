import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/register_contractor.dart';
import '../../data/services/local/login_token_service.dart';
import '../../utils/di/locator.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this._contractor)
      : super(SignupInitial(isChecked: false, isActiveButton: false));

  final RegisterContractor _contractor;

  bool isActiveButton = false;
  bool isChecked = false;
  bool emailValidity = false;
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  final fullNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  void checkBoxToggle(bool v) {
    isChecked = v;
    emit(SignupInitial(
      isActiveButton: isActiveButton,
      isChecked: isChecked,
    ));
  }

  final _loginTokenService = locator<LoginTokenService>();

  void emitInitial() {
    emit(SignupInitial(
      isActiveButton: isActiveButton,
      isChecked: isChecked,
    ));
  }

  void updateIsValid() {
    isActiveButton = emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        fullNameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        isChecked;

    emit(SignupInitial(
      isActiveButton: isActiveButton,
      isChecked: isChecked,
    ));
  }

  Future<void> register() async {
    try {
      emit(SignupLoading());
      log('Register loading');

      final response = await _contractor.register(
        phone: phoneController.text.trim(),
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // final savedRegisterData = LoginResponseModel(
      //   refresh: response.refresh,
      //   access: response.access,
      //   activeLanguage: response.activeLanguage,
      //   onboardingDone: response.onboardingDone,
      //   enableNotifications: response.enableNotifications,
      // );

      // _loginTokenService.saveLoginResponse(savedRegisterData);

      emit(SignupSuccess());
      log("Register success");
    } on DioException catch (e, s) {
      final errorMap = e.response?.data as Map<String, dynamic>?;
      String errorMessage = '';

      if (errorMap != null) {
        errorMessage =
            errorMap.values.expand((messages) => messages).join(', ');

        emit(SignupError(errorMessage));
      } else {
        emit(SignupError('An unknown error occurred'));
      }
      emit(
        SignupNetworkError(
          errorMessage,
        ),
      );

      log("Register Dio Exception: $e", stackTrace: s);
    } catch (e, s) {
      emit(SignupError(''));

      log("Register Unknown Error: $e", stackTrace: s);
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    fullNameFocusNode.dispose();
    phoneController.dispose();
    return super.close();
  }
}
