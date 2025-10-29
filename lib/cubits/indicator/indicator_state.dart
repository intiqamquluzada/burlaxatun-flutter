part of 'indicator_cubit.dart';

class IndicatorState extends Equatable {
  const IndicatorState({
    this.indicatorStatus = IndicatorStatus.initial,
    this.indicatorList,
    this.indicatorName,
    this.range,
  });

  final IndicatorStatus indicatorStatus;
  final List<IndicatorModel>? indicatorList;
  final String? indicatorName;
  final String? range;

  @override
  List<Object?> get props => [
        indicatorStatus,
        indicatorList,
        indicatorName,
        range,
      ];

  IndicatorState copyWith({
    IndicatorStatus? indicatorStatus,
    List<IndicatorModel>? indicatorList,
    String? indicatorName,
    String? range,
  }) {
    return IndicatorState(
      indicatorStatus: indicatorStatus ?? this.indicatorStatus,
      indicatorList: indicatorList ?? this.indicatorList,
      indicatorName: indicatorName ?? this.indicatorName,
      range: range ?? this.range,
    );
  }
}
