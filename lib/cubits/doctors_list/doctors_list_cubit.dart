import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/doctors_list_contractor.dart';
import '../../data/models/remote/response/doctors_list_model.dart';

part 'doctors_list_state.dart';

class DoctorsListCubit extends Cubit<DoctorsListState> {
  DoctorsListCubit(this._doctorsListContractor) : super(DoctorsListState());

  final DoctorsListContractor _doctorsListContractor;

  Future<void> getDoctorsList() async {
    try {
      emit(state.copyWith(status: DoctorsListStatus.loading));

      final response = await _doctorsListContractor.getDoctorsList();

      emit(state.copyWith(
        status: DoctorsListStatus.success,
        response: response,
      ));
    } on DioException catch (e) {
      emit(state.copyWith(
        status: DoctorsListStatus.networkError,
        errorMessage: e.toString(),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DoctorsListStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
