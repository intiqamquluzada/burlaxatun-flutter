import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/user_data_contractor.dart';
import '../../data/models/remote/response/user_data_model.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit(this._userDataContractor) : super(UserDataState());

  final UserDataContractor _userDataContractor;
  // late ValueNotifier<Baby?> currentBabyNotifier;

  final currentBabyNotifier = ValueNotifier<Baby?>(null);

  Future<void> getUserData() async {
    // currentBabyNotifier = ValueNotifier<Baby?>(null);
    try {
      emit(state.copyWith(status: UserDataStatus.loading));

      final response = await _userDataContractor.getUserData();

      final pregnantDays = response.inseminationDate != null
          ? DateTime.now()
              .difference(DateTime.parse(response.inseminationDate!))
              .inDays
          : null;

      emit(state.copyWith(
        status: UserDataStatus.success,
        response: response,
        pregnantDays: pregnantDays,
        babies: response.babies,
      ));
      log('babies count after save: ${state.babies?.length}');
    } on DioException catch (e) {
      emit(state.copyWith(
        status: UserDataStatus.networkError,
        errorMessage: e.toString(),
      ));
    } catch (e, stackTrace) {
      emit(state.copyWith(
        status: UserDataStatus.failure,
        errorMessage: e.toString(),
      ));
      debugPrint("Error: $e");
      debugPrint("Stack trace: $stackTrace");
    }
  }

  void changeProfile(Baby? currentBaby) {
    // emit(state.copyWith(currentBaby: currentBaby));
    currentBabyNotifier.value = currentBaby;
  }
}
