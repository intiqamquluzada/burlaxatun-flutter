import 'dart:developer';

import 'package:burla_xatun/data/models/remote/response/available_times_model.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/doctors_detail_contractor.dart';
import '../../data/models/remote/response/doctor_detail_model.dart';
import '../../utils/extensions/statuscode_extension.dart';

part 'doctors_detail_state.dart';

enum DoctorDetailStatus { initial, loading, success, failure, networkError }

enum AvailableTimesStatus { initial, loading, success, error, networkError }

class DoctorDetailCubit extends Cubit<DoctorDetailState> {
  DoctorDetailCubit(this._doctorDetailContractor) : super(DoctorDetailState());

  final DoctorDetailContractor _doctorDetailContractor;

  Future<void> getDoctorDetail({required int doctorId}) async {
    try {
      emit(state.copyWith(doctorDetailStatus: DoctorDetailStatus.loading));

      final response =
          await _doctorDetailContractor.getDoctorDetail(doctorId: doctorId);

      if (!response.statusCode.isSuccess) return;

      final doctorDetails = DoctorDetailsModel.fromJson(response.data);

      emit(state.copyWith(
        doctorDetailStatus: DoctorDetailStatus.success,
        doctorDetails: doctorDetails,
      ));
    } on DioException catch (e) {
      emit(state.copyWith(
        doctorDetailStatus: DoctorDetailStatus.failure,
        errorMessage: e.toString(),
      ));
    } catch (e) {
      emit(state.copyWith(
        doctorDetailStatus: DoctorDetailStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> getAvailableTimes({required String date}) async {
    try {
      emit(state.copyWith(availableTimesStatus: AvailableTimesStatus.loading));
      final response = await _doctorDetailContractor.getAvailableTimes(
        date: date,
        doctorId: state.doctorDetails?.id ?? 0,
      );

      if (!response.statusCode.isSuccess) return;

      final availableTimes =
          AvailableTimesModel.fromJson(response.data).results;

      emit(state.copyWith(
        availableTimesStatus: AvailableTimesStatus.success,
        availableTimes: availableTimes,
      ));
    } catch (e, s) {
      log('Error occured while getting available times: $e', stackTrace: s);
      emit(state.copyWith(availableTimesStatus: AvailableTimesStatus.error));
    }
  }
}
