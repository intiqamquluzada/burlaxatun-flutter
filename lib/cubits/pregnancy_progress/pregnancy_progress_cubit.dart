import 'dart:developer';

import 'package:burla_xatun/data/contractor/pregnancy_progress_contract.dart';
import 'package:burla_xatun/data/models/remote/response/pregnancy_progress_model.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'pregnancy_progress_state.dart';

enum PregnancyProgressStatus { initial, loading, success, error, networkError }

class PregnancyProgressCubit extends Cubit<PregnancyProgressState> {
  PregnancyProgressCubit(this.pregnancyProgressContract)
      : super(PregnancyProgressState());

  final PregnancyProgressContract pregnancyProgressContract;

  Future<void> getPregnancyProgress({required String week}) async {
    try {
      emit(state.copyWith(
          pregnancyProgressStatus: PregnancyProgressStatus.loading));
      final response =
          await pregnancyProgressContract.getPregnancyProgress(week: '1');

      if (!response.statusCode.isSuccess) return;
      final data = PregnancyProgressModel.fromJson(response.data);
      emit(state.copyWith(
        pregnancyProgressStatus: PregnancyProgressStatus.success,
        progressData: data.results?.first,
      ));
    } on DioException catch (e) {
      log('network error: $e');
      emit(state.copyWith(
          pregnancyProgressStatus: PregnancyProgressStatus.networkError));
    } catch (e, s) {
      log('Error occured while getting pregnancy progress: $e', stackTrace: s);
      emit(state.copyWith(
          pregnancyProgressStatus: PregnancyProgressStatus.error));
    }
  }
}
