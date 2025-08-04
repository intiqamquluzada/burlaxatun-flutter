part of 'daily_rec_cubit.dart';

class DailyRecState extends Equatable {
  const DailyRecState({
    this.status = DailyRecStatus.initial,
    this.dailyRecommendList,
    this.errorMessage,
    this.slug,
  });

  final DailyRecStatus status;
  final List<Recommendation>? dailyRecommendList;
  final String? errorMessage;
  final String? slug;

  @override
  List<Object?> get props => [
        status,
        dailyRecommendList,
        errorMessage,
      ];

  DailyRecState copyWith({
    DailyRecStatus? status,
    List<Recommendation>? dailyRecommendList,
    String? errorMessage,
    String? slug,
  }) {
    return DailyRecState(
      status: status ?? this.status,
      dailyRecommendList: dailyRecommendList ?? this.dailyRecommendList,
      slug: slug ?? this.slug,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
