import 'package:dio/dio.dart';

abstract class NotificationsContract {
  Future<Response<dynamic>> getNotifications();
  Future<Response<dynamic>> saveFcmToken({
    required String fcmToken,
    required String deviceType,
  });
}
