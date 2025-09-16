import 'package:dio/src/response.dart';

import '../contractor/notifications_contract.dart';
import '../services/remote/notification_service.dart';

class NotificationsRepo implements NotificationsContract {
  NotificationsRepo(this.notificationService);

  final NotificationService notificationService;

  @override
  Future<Response> getNotifications() {
    return notificationService.getNotifications();
  }

  @override
  Future<Response> saveFcmToken({
    required String fcmToken,
    required String deviceType,
  }) {
    return notificationService.saveFcmToken(
      fcmToken: fcmToken,
      deviceType: deviceType,
    );
  }
}
