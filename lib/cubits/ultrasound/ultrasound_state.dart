part of 'ultrasound_cubit.dart';

class UltrasoundState extends Equatable {
  const UltrasoundState({
    this.ultraSoundStatus = UltraSoundStatus.initial,
    this.ultrasoundList,
    this.ultrasoundByWeek,
  });

  final UltraSoundStatus ultraSoundStatus;
  final List<Ultrasound>? ultrasoundList;
  final Ultrasound? ultrasoundByWeek;

  @override
  List<Object?> get props => [
        ultraSoundStatus,
        ultrasoundList,
        ultrasoundByWeek,
      ];

  UltrasoundState copyWith({
    UltraSoundStatus? ultraSoundStatus,
    List<Ultrasound>? ultrasoundList,
    Ultrasound? ultrasoundByWeek,
  }) {
    return UltrasoundState(
      ultraSoundStatus: ultraSoundStatus ?? this.ultraSoundStatus,
      ultrasoundList: ultrasoundList ?? this.ultrasoundList,
      ultrasoundByWeek: ultrasoundByWeek ?? this.ultrasoundByWeek,
    );
  }
}
