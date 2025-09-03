import 'dart:developer';

import 'package:burla_xatun/data/contractor/daily_rec_contractor.dart';
import 'package:burla_xatun/data/models/remote/response/daily_rec_model.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'recommend_by_day_state.dart';

enum RecommendByDayStatus { intial, loading, success, error, networkError }

class RecommendByDayCubit extends Cubit<RecommendByDayState> {
  RecommendByDayCubit(this.dailyRecContractor) : super(RecommendByDayState());

  final DailyRecContractor dailyRecContractor;

  Future<void> getRecommendByDay({required int day}) async {
    try {
      emit(state.copyWith(recommendByDayStatus: RecommendByDayStatus.loading));

      final response = await dailyRecContractor.getDailyRec(day: day);

      if (!response.statusCode.isSuccess) return;

      final dailyRecommendationByDay = Recommendation.fromJson(response.data);
      emit(state.copyWith(
        recommendByDayStatus: RecommendByDayStatus.success,
        recommendationByDay: dailyRecommendationByDay,
      ));
    } catch (e, s) {
      log('Error occured while getting recommendation by day: $e',
          stackTrace: s);
      emit(state.copyWith(recommendByDayStatus: RecommendByDayStatus.error));
    }
  }
}
