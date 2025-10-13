import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/doctors_list_contractor.dart';
import '../../data/models/remote/response/doctors_model.dart';
import '../../data/models/remote/response/specialization_model.dart';
import '../../utils/extensions/statuscode_extension.dart';

part 'doctors_state.dart';

enum DoctorsStatus {
  initial,
  loading,
  paginationLoading,
  success,
  error,
  networkError
}

enum SpecializatonsStatus { initial, loading, success, error, networkError }

class DoctorsCubit extends Cubit<DoctorsState> {
  DoctorsCubit(this._doctorsListContractor) : super(DoctorsState());

  final DoctorsListContractor _doctorsListContractor;

  // Future<void> getDoctorDatas() async {}

  List<Specialization> specializationList = [];
  String? specializationUrl = '';

  Future<void> getSpecializations() async {
    if (specializationUrl == null ||
        state.specializationStatus == SpecializatonsStatus.loading) {
      return;
    }
    try {
      emit(state.copyWith(specializationStatus: SpecializatonsStatus.loading));

      final response = await _doctorsListContractor.getSpecializations(
        url: specializationUrl!.isEmpty ? null : specializationUrl,
      );

      if (!response.statusCode.isSuccess) return;

      final specialities = SpecializationModel.fromJson(response.data);

      specializationUrl = specialities.next;

      specialities.results?.forEach((e) {
        specializationList.add(e);
      });

      emit(state.copyWith(
        specializationStatus: SpecializatonsStatus.success,
        specializationList: List.from(specializationList),
      ));
      log('lenght species in state: ${state.specializationList?.length}');
    } catch (e, s) {
      log('Error occured while getting specializations: $e', stackTrace: s);
      emit(state.copyWith(specializationStatus: SpecializatonsStatus.error));
    }
  }

  List<Doctor> doctorList = [];
  String? doctorUrl = '';

  Future<void> getDoctorsList({
    int? specializationId,
    String? search,
  }) async {
    if (doctorUrl == null && specializationId == null ||
        state.doctorStatus == DoctorsStatus.loading) {
      return;
    }
    try {
      emit(state.copyWith(
        specializationId: specializationId,
        doctorStatus: specializationId == null
            ? DoctorsStatus.paginationLoading
            : DoctorsStatus.loading,
      ));

      final response = await _doctorsListContractor.getDoctorsList(
        specializationId: specializationId,
        search: search,
        url: specializationId != null || doctorUrl!.isEmpty ? null : doctorUrl,
      );

      if (!response.statusCode.isSuccess) return;

      final doctors = DoctorsModel.fromJson(response.data);

      doctorUrl = doctors.next;

      if (specializationId != null) {
        doctorList = [];
        doctors.results?.forEach((e) {
          doctorList.add(e);
        });
      } else {
        doctors.results?.forEach((e) {
          doctorList.add(e);
        });
      }

      emit(state.copyWith(
        doctorStatus: DoctorsStatus.success,
        doctorList: List.from(doctorList),
      ));
    } on DioException catch (e) {
      log('Error occured while getting doctors: $e');
      emit(state.copyWith(doctorStatus: DoctorsStatus.error));
    } catch (e) {
      log('Error occured while getting doctors: $e');
      emit(state.copyWith(doctorStatus: DoctorsStatus.error));
    }
  }
}
