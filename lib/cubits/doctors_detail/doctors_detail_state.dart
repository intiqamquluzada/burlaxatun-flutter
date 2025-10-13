part of 'doctors_detail_cubit.dart';

final class DoctorDetailState extends Equatable {
  const DoctorDetailState({
    this.doctorDetailStatus = DoctorDetailStatus.initial,
    this.availableTimesStatus = AvailableTimesStatus.initial,
    this.availableTimes,
    this.doctorDetails,
    this.errorMessage,
  });

  final DoctorDetailStatus doctorDetailStatus;
  final AvailableTimesStatus availableTimesStatus;
  final List<AvailableTimes>? availableTimes;
  final DoctorDetailsModel? doctorDetails;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        doctorDetailStatus,
        availableTimesStatus,
        availableTimes,
        doctorDetails,
        errorMessage,
      ];

  DoctorDetailState copyWith({
    DoctorDetailStatus? doctorDetailStatus,
    AvailableTimesStatus? availableTimesStatus,
    List<AvailableTimes>? availableTimes,
    DoctorDetailsModel? doctorDetails,
    String? errorMessage,
  }) {
    return DoctorDetailState(
      doctorDetailStatus: doctorDetailStatus ?? this.doctorDetailStatus,
      availableTimesStatus: availableTimesStatus ?? this.availableTimesStatus,
      doctorDetails: doctorDetails ?? this.doctorDetails,
      availableTimes: availableTimes ?? this.availableTimes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
