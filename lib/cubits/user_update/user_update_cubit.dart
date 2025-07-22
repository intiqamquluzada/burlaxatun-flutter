import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/user_update_contractor.dart';

part 'user_update_state.dart';

class UserUpdateCubit extends Cubit<UserUpdateState> {
  UserUpdateCubit(this._contractor)
      : super(const UserUpdateState(status: UserUpdateStatus.initial));

  final UserUpdateContractor _contractor;

  Future<void> updateUser(
      {String? phoneNumber,
      bool? onboardingDone,
      bool? wantToBePregnant,
      bool? wantToSeePeriod,
      bool? isPregnant,
      String? pregnantWeek,
      bool? firstChild,
      String? activeLanguage,
      bool? enableNotifications,
      File? image}) async {
    try {
      emit(state.copyWith(status: UserUpdateStatus.loading));
      log("User Update Loading");

      final response = await _contractor.updateUser(
        activeLanguage: activeLanguage,
        enableNotifications: enableNotifications,
        firstChild: firstChild,
        isPregnant: isPregnant,
        onboardingDone: onboardingDone,
        phoneNumber: phoneNumber,
        pregnantWeek: pregnantWeek,
        wantToBePregnant: wantToBePregnant,
        wantToSeePeriod: wantToSeePeriod,
      );

      if (response != null) {
        emit(state.copyWith(status: UserUpdateStatus.success));
        log('User Update Success');
        // locator<UserDataCubit>().state.copyWith(response: UserDataResponse());
      } else {
        emit(state.copyWith(
          status: UserUpdateStatus.failure,
          message: 'Failed to update user',
        ));
      }
    } on DioException catch (e, s) {
      emit(state.copyWith(
        status: UserUpdateStatus.networkError,
        message: e.message ?? e.toString(),
      ));
      log("User Update Dio Exception: $e", stackTrace: s);
    } catch (e, s) {
      emit(state.copyWith(
        status: UserUpdateStatus.failure,
        message: e.toString(),
      ));
      log("User Update Unknown Error: $e", stackTrace: s);
    }
  }

  Future<bool> userProfileDelete() async {
    try {
      final response = await _contractor.userProfileDelete();
      return response;
    } on DioException catch (e, s) {
      log("User Profile Delete Dio Exception: $e", stackTrace: s);
      return false;
    } catch (e, s) {
      log("User Profile Delete Unknown Error: $e", stackTrace: s);
      return false;
    }
  }
}
