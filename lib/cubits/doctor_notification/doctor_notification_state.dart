import 'package:burla_xatun/cubits/doctor_notification/doctor_notification_cubit.dart';
import 'package:burla_xatun/data/models/remote/response/my_reservations_model.dart';
import 'package:equatable/equatable.dart';

class DoctorNotificationState extends Equatable {
  const DoctorNotificationState({
    this.drNotificationStatus = DrNotificationStatus.initial,
    this.myReservations,
  });

  final DrNotificationStatus drNotificationStatus;
  final List<DoctorNotificationModel>? myReservations;

  @override
  List<Object?> get props => [
        drNotificationStatus,
        myReservations,
      ];

  DoctorNotificationState copyWith({
    DrNotificationStatus? drNotificationStatus,
    List<DoctorNotificationModel>? myReservations,
  }) {
    return DoctorNotificationState(
      drNotificationStatus: drNotificationStatus ?? this.drNotificationStatus,
      myReservations: myReservations ?? this.myReservations,
    );
  }
}
