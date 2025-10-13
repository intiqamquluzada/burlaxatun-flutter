part of 'doctor_reservation_cubit.dart';

class DoctorReservationState extends Equatable {
  const DoctorReservationState({
    this.doctorReservStatus = DoctorReservStatus.initial,
    this.reserveDate,
    this.reserveTimeId,
    this.errorMessage,
  });

  final DoctorReservStatus doctorReservStatus;
  final String? reserveDate;
  final int? reserveTimeId;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        doctorReservStatus,
        reserveDate,
        reserveTimeId,
        errorMessage,
      ];

  DoctorReservationState copyWith({
    DoctorReservStatus? doctorReservStatus,
    String? reserveDate,
    int? reserveTimeId,
    String? errorMessage,
  }) {
    return DoctorReservationState(
      doctorReservStatus: doctorReservStatus ?? this.doctorReservStatus,
      reserveDate: reserveDate ?? this.reserveDate,
      reserveTimeId: reserveTimeId ?? this.reserveTimeId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
