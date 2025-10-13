part of 'doctors_cubit.dart';

final class DoctorsState extends Equatable {
  const DoctorsState({
    this.doctorStatus = DoctorsStatus.initial,
    this.specializationStatus = SpecializatonsStatus.initial,
    this.doctorList,
    this.specializationList,
    this.specializationId,
    this.errorMessage,
  });

  final DoctorsStatus doctorStatus;
  final int? specializationId;
  final SpecializatonsStatus specializationStatus;
  final List<Doctor>? doctorList;
  final List<Specialization>? specializationList;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        doctorStatus,
        specializationId,
        specializationStatus,
        doctorList,
        errorMessage,
        specializationList,
      ];

  DoctorsState copyWith({
    SpecializatonsStatus? specializationStatus,
    int? specializationId,
    DoctorsStatus? doctorStatus,
    List<Doctor>? doctorList,
    List<Specialization>? specializationList,
    String? errorMessage,
  }) {
    return DoctorsState(
      specializationStatus: specializationStatus ?? this.specializationStatus,
      specializationId: specializationId ?? this.specializationId,
      doctorStatus: doctorStatus ?? this.doctorStatus,
      doctorList: doctorList ?? this.doctorList,
      specializationList: specializationList ?? this.specializationList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
