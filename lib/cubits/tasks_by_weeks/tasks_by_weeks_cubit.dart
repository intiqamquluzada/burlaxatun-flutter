import 'dart:developer';
import 'dart:io';

import 'package:burla_xatun/data/contractor/tasks_by_week_contract.dart';
import 'package:burla_xatun/data/models/remote/response/tasks_by_week_model.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'tasks_by_weeks_state.dart';

enum TasksByWeekStatus { initial, loading, success, error, networkError }

class TasksByWeeksCubit extends Cubit<TasksByWeeksState> {
  TasksByWeeksCubit(this.tasksByWeekContract) : super(TasksByWeeksState());

  final TasksByWeekContract tasksByWeekContract;

  Future<void> getTasksByWeek() async {
    try {
      emit(state.copWith(tasksByWeekStatus: TasksByWeekStatus.loading));
      final response = await tasksByWeekContract.getTasksByWeeks();
      if (response.statusCode.isSuccess) {
        final data = response.data as List;
        final tasks = data.map((e) => Task.fromJson(e)).toList();

        emit(state.copWith(
          tasksByWeekStatus: TasksByWeekStatus.success,
          tasksByWeek: tasks,
        ));
      } else {
        emit(state.copWith(tasksByWeekStatus: TasksByWeekStatus.error));
      }
    } on DioException catch (e) {
      final isNetworkError = e.error is SocketException ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.unknown;
      if (isNetworkError) {
        emit(state.copWith(
          tasksByWeekStatus: TasksByWeekStatus.networkError,
          networkErrorMessage: 'Network error occured',
        ));
      }
    } catch (e, s) {
      log('Error occured while getting tasks by week: $e', stackTrace: s);
      emit(state.copWith(tasksByWeekStatus: TasksByWeekStatus.error));
    }
  }
}
