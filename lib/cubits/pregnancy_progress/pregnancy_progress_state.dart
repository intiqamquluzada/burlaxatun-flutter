part of 'pregnancy_progress_cubit.dart';

class PregnancyProgressState extends Equatable {
  const PregnancyProgressState({
    this.pregnancyProgressStatus = PregnancyProgressStatus.initial,
    this.progressData,
    this.errorMessage,
  });

  final PregnancyProgressStatus pregnancyProgressStatus;
  final PregnancyProgressModel? progressData;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        pregnancyProgressStatus,
        progressData,
        errorMessage,
      ];

  PregnancyProgressState copyWith({
    PregnancyProgressStatus? pregnancyProgressStatus,
    PregnancyProgressModel? progressData,
    String? errorMessage,
  }) {
    return PregnancyProgressState(
      pregnancyProgressStatus:
          pregnancyProgressStatus ?? this.pregnancyProgressStatus,
      progressData: progressData ?? this.progressData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
