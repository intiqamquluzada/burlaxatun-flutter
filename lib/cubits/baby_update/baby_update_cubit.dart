import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/baby_update_contract.dart';
import '../../utils/extensions/statuscode_extension.dart';

part 'baby_update_state.dart';

enum BabyUpdateStatus { intial, loading, error, success, networkError }

class BabyUpdateCubit extends Cubit<BabyUpdateState> {
  BabyUpdateCubit(this.babyUpdateContract) : super(BabyUpdateState());

  final BabyUpdateContract babyUpdateContract;

  Future<void> updateBabyData({
    String? name,
    int? height,
    int? weight,
    String? gender,
    String? birthDate,
    bool? haveBorn,
    bool? isFirst,
    bool? haveMiscarriage,
  }) async {
    try {
      emit(state.copyWith(status: BabyUpdateStatus.loading));
      final response = await babyUpdateContract.updateBabyData(
        name: name,
        weight: weight,
        gender: gender,
        birthDate: birthDate,
        haveBorn: haveBorn,
        isFirst: isFirst,
        haveMiscarriage: haveMiscarriage,
      );
      if (!response.statusCode.isSuccess) return;
      emit(state.copyWith(status: BabyUpdateStatus.success));
    } catch (e, s) {
      log('Error occured while updating baby data: $e', stackTrace: s);
      emit(state.copyWith(status: BabyUpdateStatus.error));
    }
  }
}
