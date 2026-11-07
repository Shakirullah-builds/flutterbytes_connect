import 'package:flutter/foundation.dart';

import '../../data/matchmaker_repository.dart';
import 'matchmaker_state.dart';

class MatchmakerController extends ValueNotifier<MatchmakerState> {
  final MatchmakerRepository _repository;

  MatchmakerController({MatchmakerRepository? repository})
      : _repository = repository ?? ServerpodMatchmakerRepository(),
        super(const MatchmakerState());

  Future<void> pairDevelopers({
    required int devOneId,
    required int devTwoId,
  }) async {
    value = value.copyWith(
      status: MatchmakerStatus.loading,
      errorMessage: null,
    );

    try {
      final match = await _repository.generatePitch(
        devOneId: devOneId,
        devTwoId: devTwoId,
      );

      value = value.copyWith(
        status: MatchmakerStatus.success,
        match: match,
      );
    } catch (e) {
      value = value.copyWith(
        status: MatchmakerStatus.failure,
        errorMessage: e.toString().replaceAll('Exception:', '').trim(),
      );
    }
  }
}
