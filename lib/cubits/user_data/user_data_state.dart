part of 'user_data_cubit.dart';

enum UserDataStatus { initial, loading, success, failure, networkError }

final class UserDataState extends Equatable {
  const UserDataState({
    this.status = UserDataStatus.initial,
    this.response,
    this.errorMessage,
    this.babies,
    this.pregnantDays,
    // required this.currentBaby,
  });

  final UserDataStatus status;
  final UserDataResponse? response;
  final List<Baby>? babies;
  // final Baby? currentBaby;
  final String? errorMessage;
  final int? pregnantDays;

  @override
  List<Object?> get props => [
        status,
        response,
        errorMessage,
        babies,
        pregnantDays,
      ];

  UserDataState copyWith({
    UserDataStatus? status,
    UserDataResponse? response,
    String? errorMessage,
    List<Baby>? babies,
    int? pregnantDays,
    // Baby? currentBaby,
  }) {
    return UserDataState(
      status: status ?? this.status,
      response: response ?? this.response,
      errorMessage: errorMessage ?? this.errorMessage,
      babies: babies ?? this.babies,
      pregnantDays: pregnantDays ?? this.pregnantDays,
      // currentBaby: currentBaby,
    );
  }

  // factory UserDataState.initial() => const UserDataState(
  //       status: UserDataStatus.initial,
  //       response: null,
  //       errorMessage: null,
  //       pregnantDays: null,
  //       babies: [],
  //       // currentBaby: null,
  //     );
}
