import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:burla_xatun/cubits/doctor_notification/doctor_notification_state.dart';
import 'package:burla_xatun/data/contractor/dr_notifications_contract.dart';
import 'package:burla_xatun/data/models/remote/response/my_reservations_model.dart';
import 'package:burla_xatun/utils/extensions/statuscode_extension.dart';

enum DrNotificationStatus { initial, loading, success, error }

class DoctorNotificationCubit extends Cubit<DoctorNotificationState> {
  DoctorNotificationCubit(this.drNotificationsContract)
      : super(DoctorNotificationState());

  final DrNotificationsContract drNotificationsContract;

  Future<void> getDrNotifications() async {
    try {
      emit(state.copyWith(drNotificationStatus: DrNotificationStatus.loading));
      final response = await drNotificationsContract.getDrNotifications();

      if (!response.statusCode.isSuccess) return;
      final data = response.data as List;
      final reservations = data
          .map((reservation) => MyReservationsModel.fromJson(reservation))
          .toList();
      emit(state.copyWith(
        drNotificationStatus: DrNotificationStatus.success,
        myReservations: reservations,
      ));
    } catch (e, s) {
      log('Error occured while getting dr notifications: e', stackTrace: s);
      emit(state.copyWith(drNotificationStatus: DrNotificationStatus.error));
    }
  }
}
