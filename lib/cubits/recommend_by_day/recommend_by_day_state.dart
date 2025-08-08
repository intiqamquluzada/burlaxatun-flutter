part of 'recommend_by_day_cubit.dart';

class RecommendByDayState extends Equatable {
  const RecommendByDayState({
    this.recommendByDayStatus = RecommendByDayStatus.intial,
    this.recommendationByDay,
  });

  final RecommendByDayStatus recommendByDayStatus;
  final Recommendation? recommendationByDay;

  @override
  List<Object?> get props => [
        recommendByDayStatus,
        recommendationByDay,
      ];

  RecommendByDayState copyWith({
    RecommendByDayStatus? recommendByDayStatus,
    Recommendation? recommendationByDay,
  }) {
    return RecommendByDayState(
      recommendByDayStatus: recommendByDayStatus ?? this.recommendByDayStatus,
      recommendationByDay: recommendationByDay ?? this.recommendationByDay,
    );
  }
}
