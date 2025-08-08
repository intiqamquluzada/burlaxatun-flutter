part of 'daily_rec_cubit.dart';

class DailyRecState extends Equatable {
  const DailyRecState({
    this.status = DailyRecStatus.initial,
    this.myRecommendation,
    this.errorMessage,
    this.slug,
  });

  final DailyRecStatus status;
  final Recommendation? myRecommendation;
  final String? errorMessage;
  final String? slug;

  @override
  List<Object?> get props => [
        status,
        myRecommendation,
        errorMessage,
      ];

  DailyRecState copyWith({
    DailyRecStatus? status,
    Recommendation? myRecommendation,
    String? errorMessage,
    String? slug,
  }) {
    return DailyRecState(
      status: status ?? this.status,
      myRecommendation: myRecommendation ?? this.myRecommendation,
      slug: slug ?? this.slug,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
