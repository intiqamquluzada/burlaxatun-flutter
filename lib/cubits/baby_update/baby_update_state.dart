part of 'baby_update_cubit.dart';

class BabyUpdateState extends Equatable {
  const BabyUpdateState({
    this.status = BabyUpdateStatus.intial,
  });

  final BabyUpdateStatus status;

  @override
  List<Object> get props => [
        status,
      ];

  BabyUpdateState copyWith({
    BabyUpdateStatus? status,
  }) {
    return BabyUpdateState(
      status: status ?? this.status,
    );
  }
}
