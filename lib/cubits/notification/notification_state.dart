part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.notificationStatus = NotificationStatus.initial,
    this.enableNotificationStatus = EnableNotificationStatus.initial,
    this.notifications,
  });

  final NotificationStatus notificationStatus;
  final EnableNotificationStatus? enableNotificationStatus;
  final List<NotificationsModel>? notifications;

  @override
  List<Object?> get props => [
        notificationStatus,
        enableNotificationStatus,
        notifications,
      ];

  NotificationState copyWith({
    NotificationStatus? notificationStatus,
    EnableNotificationStatus? enableNotificationStatus,
    List<NotificationsModel>? notifications,
  }) {
    return NotificationState(
      notificationStatus: notificationStatus ?? this.notificationStatus,
      enableNotificationStatus:
          enableNotificationStatus ?? this.enableNotificationStatus,
      notifications: notifications ?? this.notifications,
    );
  }
}
