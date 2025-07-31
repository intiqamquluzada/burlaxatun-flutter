part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.changePasswordStatus = ChangePasswordStatus.initial,
  });

  final ChangePasswordStatus changePasswordStatus;

  @override
  List<Object> get props => [
        changePasswordStatus,
      ];

  ChangePasswordState copWith({
    ChangePasswordStatus? changePasswordStatus,
  }) {
    return ChangePasswordState(
      changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
    );
  }
}
