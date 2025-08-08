part of 'select_task_cubit.dart';

class SelectTaskState extends Equatable {
  const SelectTaskState({
    this.selectTaskStatus = SelectTaskStatus.initial,
  });

  final SelectTaskStatus selectTaskStatus;
  @override
  List<Object> get props => [
        selectTaskStatus,
      ];

  SelectTaskState copyWith({
    SelectTaskStatus? selectTaskStatus,
  }) {
    return SelectTaskState(
      selectTaskStatus: selectTaskStatus ?? this.selectTaskStatus,
    );
  }
}
