import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../data/contractor/ultrasound_contract.dart';
import '../../data/models/remote/response/ultrasound_model.dart';
import '../../utils/extensions/statuscode_extension.dart';

part 'ultrasound_state.dart';

enum UltraSoundStatus { initial, loading, success, error, networkError }

class UltrasoundCubit extends Cubit<UltrasoundState> {
  UltrasoundCubit(this.ultrasoundContract) : super(UltrasoundState());

  final UltrasoundContract ultrasoundContract;

  Future<void> getUltraSound({required int week}) async {
    // if (state.ultrasoundByWeek != null) return;

    try {
      emit(state.copyWith(ultraSoundStatus: UltraSoundStatus.loading));
      final response = await ultrasoundContract.getUltraSound(week: week);

      if (!response.statusCode.isSuccess) return;

      // final ultrasoundData = UltrasoundModel.fromJson(response.data);
      final ultrasoundByWeek = Ultrasound.fromJson(response.data);
      emit(state.copyWith(
        ultraSoundStatus: UltraSoundStatus.success,
        // ultrasoundList: ultrasoundData.results,
        ultrasoundByWeek: ultrasoundByWeek,
      ));
    } on DioException catch (e, s) {
      if (e.type == DioExceptionType.connectionError) {
        log('Network error: $e');
        emit(state.copyWith(ultraSoundStatus: UltraSoundStatus.networkError));
      } else {
        log('Error occured while getting ultrasound: $e', stackTrace: s);
        emit(state.copyWith(ultraSoundStatus: UltraSoundStatus.error));
      }
    } catch (e, s) {
      log('Error occured while getting ultrasound: $e', stackTrace: s);
      emit(state.copyWith(ultraSoundStatus: UltraSoundStatus.error));
    }
  }
}
