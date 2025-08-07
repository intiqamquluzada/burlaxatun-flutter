part of 'report_or_block_user_cubit.dart';

class ReportOrBlockUserState extends Equatable {
  const ReportOrBlockUserState({
    this.reportStatus = ReportStatus.initial,
    this.blockStatus = BlockStatus.initial,
    this.reportForumStatus = ReportForumStatus.initial,
    this.blockForumStatus = BlockForumStatus.initial,
    this.error,
  });

  final ReportStatus reportStatus;
  final BlockStatus blockStatus;
  final ReportForumStatus reportForumStatus;
  final BlockForumStatus blockForumStatus;
  final String? error;

  @override
  List<Object?> get props => [
        reportStatus,
        blockStatus,
        reportForumStatus,
        blockForumStatus,
        error,
      ];

  ReportOrBlockUserState copyWith({
    ReportStatus? reportStatus,
    BlockStatus? blockStatus,
    ReportForumStatus? reportForumStatus,
    BlockForumStatus? blockForumStatus,
    String? error,
  }) {
    return ReportOrBlockUserState(
      reportStatus: reportStatus ?? this.reportStatus,
      blockStatus: blockStatus ?? this.blockStatus,
      reportForumStatus: reportForumStatus ?? this.reportForumStatus,
      blockForumStatus: blockForumStatus ?? this.blockForumStatus,
      error: error,
    );
  }
}
