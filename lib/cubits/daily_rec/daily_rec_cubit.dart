import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/daily_rec_contractor.dart';
import '../../data/models/remote/response/daily_rec_model.dart';
import '../../utils/extensions/statuscode_extension.dart';

part 'daily_rec_state.dart';

enum DailyRecStatus { initial, loading, success, failure, networkError }

class DailyRecCubit extends Cubit<DailyRecState> {
  DailyRecCubit(this._dailyRecContractor) : super(DailyRecState());

  final DailyRecContractor _dailyRecContractor;

  List<Recommendation> recommendList = [];
  Future<void> getDailyRec() async {
    try {
      emit(state.copyWith(status: DailyRecStatus.loading));

      final response = await _dailyRecContractor.getDailyRec();

      if (!response.statusCode.isSuccess) return;

      final myRecommendation = Recommendation.fromJson(response.data);

      // recommendList = data.results ?? [];
      emit(state.copyWith(
        status: DailyRecStatus.success, 
        myRecommendation: myRecommendation,
      ));

      //
    } on DioException catch (e) {
      emit(state.copyWith(
        status: DailyRecStatus.networkError,
        errorMessage: e.toString(),
      ));
    } catch (e, s) {
      log('Error occured while getting daily recommends: $e', stackTrace: s);
      emit(state.copyWith(
        status: DailyRecStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
