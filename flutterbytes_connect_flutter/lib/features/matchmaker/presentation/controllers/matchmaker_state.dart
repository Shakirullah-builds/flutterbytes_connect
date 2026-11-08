import 'package:flutterbytes_connect_client/flutterbytes_connect_client.dart';

enum MatchmakerStatus { initial, loading, success, failure }

class MatchmakerState {
  final MatchmakerStatus status;
  final CollabMatch? match;
  final String? errorMessage;

  const MatchmakerState({
    this.status = MatchmakerStatus.initial,
    this.match,
    this.errorMessage,
  });

  bool get isLoading => status == MatchmakerStatus.loading;
  bool get isSuccess => status == MatchmakerStatus.success;

  MatchmakerState copyWith({
    MatchmakerStatus? status,
    CollabMatch? match,
    String? errorMessage,
  }) {
    return MatchmakerState(
      status: status ?? this.status,
      match: match ?? this.match,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
