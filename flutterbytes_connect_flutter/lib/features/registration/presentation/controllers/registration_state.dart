import 'package:flutterbytes_connect_client/flutterbytes_connect_client.dart';

enum RegistrationStatus { initial, loading, success, failure }

class RegistrationState {
  final RegistrationStatus status;
  final AttendeeProfile? createdProfile;
  final String? errorMessage;

  const RegistrationState({
    this.status = RegistrationStatus.initial,
    this.createdProfile,
    this.errorMessage,
  });

  bool get isLoading => status == RegistrationStatus.loading;
  bool get isSuccess => status == RegistrationStatus.success;

  RegistrationState copyWith({
    RegistrationStatus? status,
    AttendeeProfile? createdProfile,
    String? errorMessage,
  }) {
    return RegistrationState(
      status: status ?? this.status,
      createdProfile: createdProfile ?? this.createdProfile,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
