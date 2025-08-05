part of 'pregnancy_progress_cubit.dart';

class PregnancyProgressState extends Equatable {
  const PregnancyProgressState({
    this.pregnancyProgressStatus = PregnancyProgressStatus.initial,
    this.progressData,
  });

  final PregnancyProgressStatus pregnancyProgressStatus;
  final PregnancyProgressModel? progressData;

  @override
  List<Object?> get props => [
        pregnancyProgressStatus,
        progressData,
      ];

  PregnancyProgressState copyWith({
    PregnancyProgressStatus? pregnancyProgressStatus,
    PregnancyProgressModel? progressData,
  }) {
    return PregnancyProgressState(
      pregnancyProgressStatus:
          pregnancyProgressStatus ?? this.pregnancyProgressStatus,
      progressData: progressData ?? this.progressData,
    );
  }
}
