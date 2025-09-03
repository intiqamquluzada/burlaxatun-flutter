import 'dart:developer';

import 'package:burla_xatun/data/contractor/change_password_contract.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'change_password_state.dart';

enum ChangePasswordStatus { initial, loading, error, success }

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.changePasswordContract)
      : super(ChangePasswordState());

  final ChangePasswordContract changePasswordContract;

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword1,
    required String newPassword2,
  }) async {
    try {
      emit(state.copWith(changePasswordStatus: ChangePasswordStatus.loading));
      final response = await changePasswordContract.changePassword(
        oldPassword: oldPassword,
        newPassword1: newPassword1,
        newPassword2: newPassword2,
      );

      if (!response.statusCode.isSuccess) return;
      emit(state.copWith(changePasswordStatus: ChangePasswordStatus.success));
    } catch (e, s) {
      log('Error occured while changing password', stackTrace: s);
      emit(state.copWith(changePasswordStatus: ChangePasswordStatus.error));
    }
  }
}
