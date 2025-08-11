import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/tasks_by_week_contract.dart';
import '../../data/models/remote/response/tasks_by_week_model.dart';
import '../../utils/extensions/statuscode_extension.dart';

part 'tasks_by_weeks_state.dart';

enum TasksByWeekStatus { initial, loading, success, error, networkError }

class TasksByWeeksCubit extends Cubit<TasksByWeeksState> {
  TasksByWeeksCubit(this.tasksByWeekContract) : super(TasksByWeeksState());

  final TasksByWeekContract tasksByWeekContract;

  Future<void> getTasksByWeek() async {
    try {
      emit(state.copWith(tasksByWeekStatus: TasksByWeekStatus.loading));
      final response = await tasksByWeekContract.getTasksByWeeks();

      if (!response.statusCode.isSuccess) return;

      final data = response.data as List;

      final tasks = data.map((e) => Task.fromJson(e)).toList();

      emit(state.copWith(
        tasksByWeekStatus: TasksByWeekStatus.success,
        tasksByWeek: tasks,
      ));
    } on DioException catch (e) {
      // if (e.type == DioExceptionType.badResponse) {
      //   final error = e.response?.data['detail'];
      //   emit(state.copWith(
      //     tasksByWeekStatus: TasksByWeekStatus.error,
      //     errorMessage: error,
      //   ));
      // } else {
      //   emit(state.copWith(
      //     tasksByWeekStatus: TasksByWeekStatus.networkError,
      //     networkErrorMessage: 'Şəbəkəni yoxlayın',
      //   ));
      // }
      emit(state.copWith(
        tasksByWeekStatus: TasksByWeekStatus.networkError,
        networkErrorMessage: '',
      ));
    } catch (e, s) {
      log('Error occured while getting tasks by week: $e', stackTrace: s);
      emit(state.copWith(tasksByWeekStatus: TasksByWeekStatus.error));
    }
  }
}
