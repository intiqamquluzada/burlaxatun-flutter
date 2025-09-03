import 'dart:developer';

import 'package:burla_xatun/data/contractor/select_task_contract.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_task_state.dart';

enum SelectTaskStatus { initial, loading, error, success }

class SelectTaskCubit extends Cubit<SelectTaskState> {
  SelectTaskCubit(this.selectTaskContract) : super(SelectTaskState());

  final SelectTaskContract selectTaskContract;

  Future<bool> selectTask({
    required bool isSelected,
    required int taskId,
  }) async {
    try {
      emit(state.copyWith(selectTaskStatus: SelectTaskStatus.loading));
      final response = isSelected
          ? await selectTaskContract.selectTask(taskId: taskId)
          : await selectTaskContract.declineTask(taskId: taskId);

      if (response.statusCode.isSuccess) {
        emit(state.copyWith(selectTaskStatus: SelectTaskStatus.success));
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      log('Error occured while selecting task: $e', stackTrace: s);
      emit(state.copyWith(selectTaskStatus: SelectTaskStatus.error));
      return false;
    }
  }

  Future<void> declineTask() async {
    try {
      //
    } catch (e, s) {
      log('Error occured while declining task: $e', stackTrace: s);
    }
  }
}
