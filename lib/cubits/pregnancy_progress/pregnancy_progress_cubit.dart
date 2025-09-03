import 'dart:developer';

import 'package:burla_xatun/data/contractor/pregnancy_progress_contract.dart';
import 'package:burla_xatun/data/models/remote/response/pregnancy_progress_model.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'pregnancy_progress_state.dart';

enum PregnancyProgressStatus { initial, loading, success, error, networkError }

class PregnancyProgressCubit extends Cubit<PregnancyProgressState> {
  PregnancyProgressCubit(this.pregnancyProgressContract)
      : super(PregnancyProgressState());

  final PregnancyProgressContract pregnancyProgressContract;

  Future<void> getPregnancyProgress({required DateTime date}) async {
    try {
      emit(state.copyWith(
          pregnancyProgressStatus: PregnancyProgressStatus.loading));
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      final response = await pregnancyProgressContract.getPregnancyProgress(
        date: formattedDate,
      );

      if (!response.statusCode.isSuccess) return;
      // final data = response.data as List;
      final progress = PregnancyProgressModel.fromJson(response.data);
      emit(state.copyWith(
        pregnancyProgressStatus: PregnancyProgressStatus.success,
        progressData: progress,
      ));
    } on DioException catch (e) {
      log('network error: $e');
      if (e.type == DioExceptionType.badResponse) {
        final error = e.response?.data['detail'];
        emit(state.copyWith(
            errorMessage: error,
            pregnancyProgressStatus: PregnancyProgressStatus.error));
      } else {
        emit(state.copyWith(
            pregnancyProgressStatus: PregnancyProgressStatus.networkError));
      }
    } catch (e, s) {
      log('Error occured while getting pregnancy progress: $e', stackTrace: s);
      emit(state.copyWith(
        pregnancyProgressStatus: PregnancyProgressStatus.error,
      ));
    }
  }
}
