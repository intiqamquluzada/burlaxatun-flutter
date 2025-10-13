import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/indicator_contract.dart';
import '../../data/models/remote/request/add_indicator_request_model.dart';
import '../../data/models/remote/response/indicator_model.dart';
import '../../utils/extensions/statuscode_extension.dart';

part 'indicator_state.dart';

enum IndicatorStatus { initial, loading, success, error, networkError }

class IndicatorCubit extends Cubit<IndicatorState> {
  IndicatorCubit(this.indicatorContract) : super(IndicatorState());

  final IndicatorContract indicatorContract;

  Future<void> getIndicatorDatas({
    int? babyId,
    required String indicatorName,
    required String range,
  }) async {
    try {
      emit(state.copyWith(indicatorStatus: IndicatorStatus.loading));
      final response = await indicatorContract.getIndicator(
        babyId: babyId,
        indicatorName: indicatorName,
        range: range,
      );
      if (response.statusCode.isSuccess) {
        final indicatorData = response.data as List;
        final indicatorList =
            indicatorData.map((e) => IndicatorModel.fromJson(e)).toList();
        emit(state.copyWith(
          indicatorStatus: IndicatorStatus.success,
          indicatorList: indicatorList,
        ));
        // emit(state.copyWith(
        //   indicatorList: indicatorList,
        // ));
      }
    } on DioException catch (e, s) {
      if (e.type is SocketException) {
        log('network error');
        emit(state.copyWith(indicatorStatus: IndicatorStatus.networkError));
      }
      log('Error occured while gettinng indicator data: $e', stackTrace: s);
      emit(state.copyWith(indicatorStatus: IndicatorStatus.error));
    } catch (e, s) {
      log('Error occured while gettinng indicator data: $e', stackTrace: s);
      emit(state.copyWith(indicatorStatus: IndicatorStatus.error));
    }
  }

  void addIndicator({
    required String indicatorName,
    required String indicator,
    required String date,
    required String time,
    int? babyId,
  }) async {
    try {
      emit(state.copyWith(indicatorStatus: IndicatorStatus.loading));

      final postData = AddIndicatorRequestModel(
        babyId: babyId,
        indicator: indicator,
        name: indicatorName,
        date: date,
        time: time,
      ).toJson();
      final response = await indicatorContract.addIndicator(postData: postData);

      if (response.statusCode.isSuccess) {
        emit(state.copyWith(indicatorStatus: IndicatorStatus.success));
      } else {
        emit(state.copyWith(indicatorStatus: IndicatorStatus.error));
      }
    } on DioException catch (e, s) {
      if (e.type is SocketException) {
        log('network error');
        emit(state.copyWith(indicatorStatus: IndicatorStatus.networkError));
      }
      log('Error occured while adding indicator data: $e', stackTrace: s);
      emit(state.copyWith(indicatorStatus: IndicatorStatus.error));
    } catch (e, s) {
      log('Error occured while adding indicator data: $e', stackTrace: s);
      emit(state.copyWith(indicatorStatus: IndicatorStatus.error));
    }
  }
}
