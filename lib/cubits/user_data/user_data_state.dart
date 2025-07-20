part of 'user_data_cubit.dart';

enum UserDataStatus { initial, loading, success, failure, networkError }

final class UserDataState extends Equatable {
  const UserDataState({
    required this.status,
    required this.response,
    required this.errorMessage,
    required this.babies,
    // required this.currentBaby,
  });

  final UserDataStatus status;
  final UserDataResponse? response;
  final List<Baby>? babies;
  // final Baby? currentBaby;
  final String? errorMessage;

  UserDataState copyWith({
    UserDataStatus? status,
    UserDataResponse? response,
    String? errorMessage,
    List<Baby>? babies,
    // Baby? currentBaby,
  }) {
    return UserDataState(
      status: status ?? this.status,
      response: response ?? this.response,
      errorMessage: errorMessage ?? this.errorMessage,
      babies: babies ?? this.babies,
      // currentBaby: currentBaby,
    );
  }

  factory UserDataState.initial() => const UserDataState(
        status: UserDataStatus.initial,
        response: null,
        errorMessage: null,
        babies: [],
        // currentBaby: null,
      );

  @override
  List<Object?> get props => [status, response, errorMessage, babies];
}
