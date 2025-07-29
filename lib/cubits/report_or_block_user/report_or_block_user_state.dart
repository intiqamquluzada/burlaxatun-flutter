part of 'report_or_block_user_cubit.dart';

class ReportOrBlockUserState extends Equatable {
  const ReportOrBlockUserState({
    this.reportStatus = ReportStatus.initial,
    this.blockStatus = BlockStatus.initial,
    this.error,
  });

  final ReportStatus reportStatus;
  final BlockStatus blockStatus;
  final String? error;

  @override
  List<Object?> get props => [
        reportStatus,
        blockStatus,
        error,
      ];

  ReportOrBlockUserState copyWith({
    ReportStatus? reportStatus,
    BlockStatus? blockStatus,
    String? error,
  }) {
    return ReportOrBlockUserState(
      reportStatus: reportStatus ?? this.reportStatus,
      blockStatus: blockStatus ?? this.blockStatus,
      error: error
    );
  }
}
