import 'dart:developer';

import 'package:burla_xatun/data/contractor/report_or_block_contract.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'report_or_block_user_state.dart';

enum ReportStatus { initial, loading, error, success }

enum BlockStatus { initial, loading, error, success }

class ReportOrBlockUserCubit extends Cubit<ReportOrBlockUserState> {
  ReportOrBlockUserCubit(this.reportOrBlockContract)
      : super(ReportOrBlockUserState());

  final ReportOrBlockContract reportOrBlockContract;

  Future<void> reportComment(int commentId) async {
    try {
      emit(state.copyWith(reportStatus: ReportStatus.loading));
      final response =
          await reportOrBlockContract.reportComment(commentId: commentId);

      if (!response.statusCode.isSuccess) return;
      emit(state.copyWith(reportStatus: ReportStatus.success));
    } on DioException catch (e) {
      final error = e.response?.data;
      emit(state.copyWith(
        reportStatus: ReportStatus.error,
        error: error['detail'][0],
      ));
    } catch (e, s) {
      log('Error occured while reporting comment: $e', stackTrace: s);
      emit(state.copyWith(reportStatus: ReportStatus.error));
    }
  }

  Future<void> blockUser(int userId) async {
    try {
      emit(state.copyWith(blockStatus: BlockStatus.loading));
      final response = await reportOrBlockContract.blockUser(userId: userId);
      if (!response.statusCode.isSuccess) return;
      emit(state.copyWith(blockStatus: BlockStatus.success));
    } on DioException catch (e) {
      final error = e.response?.data;
      emit(state.copyWith(
        blockStatus: BlockStatus.error,
        error: error['blocked_user'][0],
      ));
    } catch (e, s) {
      log(e.toString());
      log('Error occured while blocking user: $e', stackTrace: s);
      emit(state.copyWith(blockStatus: BlockStatus.error));
    }
  }
}
