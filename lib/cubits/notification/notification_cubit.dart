import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/contractor/notifications_contract.dart';
import '../../data/models/remote/response/notifications_model.dart';
import '../../utils/extensions/statuscode_extension.dart';

part 'notification_state.dart';

enum NotificationStatus { initial, loading, error, networkError, success }

enum EnableNotificationStatus { initial, loading, error, success }

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.notificationsContract) : super(NotificationState());

  final NotificationsContract notificationsContract;

  Future<void> getNofitications() async {
    try {
      emit(state.copyWith(notificationStatus: NotificationStatus.loading));
      final response = await notificationsContract.getNotifications();

      if (response.statusCode.isSuccess) {
        final data = response.data as List;
        final notifications =
            data.map((e) => NotificationsModel.fromJson(e)).toList();
        emit(state.copyWith(
          notificationStatus: NotificationStatus.success,
          notifications: notifications,
        ));
      }
    } on DioException catch (e, s) {
      log('Error occured while getting notifications: $e', stackTrace: s);
      emit(state.copyWith(notificationStatus: NotificationStatus.error));
    }
  }

  Future<void> enableNotification({
    required String fcmToken,
    required String deviceType,
  }) async {
    try {
      emit(state.copyWith(
          enableNotificationStatus: EnableNotificationStatus.loading));
      final response = await notificationsContract.saveFcmToken(
        fcmToken: fcmToken,
        deviceType: deviceType,
      );

      if (response.statusCode.isSuccess) {
        emit(state.copyWith(
            enableNotificationStatus: EnableNotificationStatus.success));
      }
    } catch (e, s) {
      log('Error occured while enabling notification: $e', stackTrace: s);
      emit(state.copyWith(
          enableNotificationStatus: EnableNotificationStatus.error));
    }
  }
}
