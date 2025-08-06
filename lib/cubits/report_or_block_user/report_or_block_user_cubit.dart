import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/report_or_block_contract.dart';
import '../../utils/extensions/statuscode_extension.dart';

part 'report_or_block_user_state.dart';

enum ReportStatus { initial, loading, error, success }

enum BlockStatus { initial, loading, error, success }

enum ReportForumStatus { initial, loading, error, success }

enum BlockForumStatus { initial, loading, error, success }

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

  Future<void> reportForum({required int forumId}) async {
    try {
      emit(state.copyWith(reportForumStatus: ReportForumStatus.loading));
      final response =
          await reportOrBlockContract.reportForum(forumId: forumId);
      if (!response.statusCode.isSuccess) return;
      emit(state.copyWith(reportForumStatus: ReportForumStatus.success));
    } on DioException catch (e) {
      final error = e.response?.data;
      emit(state.copyWith(
        reportForumStatus: ReportForumStatus.error,
        error: error['detail'][0],
      ));
    } catch (e, s) {
      log(e.toString());
      log('Error occured while blocking user: $e', stackTrace: s);
      emit(state.copyWith(reportForumStatus: ReportForumStatus.error));
    }
  }

  Future<void> blockForum({required int forumId}) async {
    try {
      emit(state.copyWith(blockForumStatus: BlockForumStatus.loading));
      final response = await reportOrBlockContract.blockForum(forumId: forumId);
      if (!response.statusCode.isSuccess) return;
      emit(state.copyWith(blockForumStatus: BlockForumStatus.success));
    } on DioException catch (e) {
      final error = e.response?.data;
      emit(state.copyWith(
        blockForumStatus: BlockForumStatus.error,
        error: error['detail'][0],
      ));
    } catch (e, s) {
      log(e.toString());
      log('Error occured while blocking user: $e', stackTrace: s);
      emit(state.copyWith(blockForumStatus: BlockForumStatus.error));
    }
  }
}
