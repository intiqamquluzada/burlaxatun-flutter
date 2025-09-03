part of 'tasks_by_weeks_cubit.dart';

class TasksByWeeksState extends Equatable {
  const TasksByWeeksState({
    this.tasksByWeekStatus = TasksByWeekStatus.initial,
    this.networkErrorMessage,
    this.tasksByWeek,
    this.errorMessage,
  });

  final TasksByWeekStatus tasksByWeekStatus;
  final List<Task>? tasksByWeek;
  final String? networkErrorMessage;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        tasksByWeekStatus,
        networkErrorMessage,
        tasksByWeek,
        errorMessage,
      ];

  TasksByWeeksState copWith({
    TasksByWeekStatus? tasksByWeekStatus,
    String? networkErrorMessage,
    List<Task>? tasksByWeek,
    String? errorMessage,
  }) {
    return TasksByWeeksState(
      tasksByWeekStatus: tasksByWeekStatus ?? this.tasksByWeekStatus,
      networkErrorMessage: networkErrorMessage ?? this.networkErrorMessage,
      tasksByWeek: tasksByWeek ?? this.tasksByWeek,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
