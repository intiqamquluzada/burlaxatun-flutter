import 'dart:developer';

import 'package:burla_xatun/data/contractor/doctor_reserv_contract.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'doctor_reservation_state.dart';

enum DoctorReservStatus { initial, loading, success, error }

class DoctorReservationCubit extends Cubit<DoctorReservationState> {
  DoctorReservationCubit(this._doctorReservContract)
      : super(DoctorReservationState());

  final DoctorReservContract _doctorReservContract;

  void saveTime(String v) {
    emit(state.copyWith(reserveTime: v));
  }

  void saveDate(String v) {
    emit(state.copyWith(reserveDate: v));
  }

  Future<void> reservDoctor(int doctorId) async {
    if (state.reserveDate == null|| state.reserveTime == null) {
      emit(state.copyWith(
        errorMessage: 'Vaxt və tarix seçin',
        doctorReservStatus: DoctorReservStatus.error,
      ));
      emit(state.copyWith(doctorReservStatus: DoctorReservStatus.initial));
      return;
    }
    try {
      emit(state.copyWith(doctorReservStatus: DoctorReservStatus.loading));
      final response = await _doctorReservContract.reserveDoctor(
        postData: {
          "doctor": doctorId,
          "reserve_date": state.reserveDate,
          "reserve_time": state.reserveTime,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(state.copyWith(doctorReservStatus: DoctorReservStatus.success));
      }
    } on DioException catch (e, s) {
      // final errorMessage = e.response?.data['non_field_errors'] ?? 'error occured';
      log('error occured while doctor reservation: $e', stackTrace: s);
      emit(state.copyWith(
        doctorReservStatus: DoctorReservStatus.error,
        errorMessage: 'Xəta baş verdi',
      ));
    }
  }
}
