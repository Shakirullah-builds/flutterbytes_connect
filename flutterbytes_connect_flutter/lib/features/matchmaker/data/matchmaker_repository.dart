import 'package:flutterbytes_connect_client/flutterbytes_connect_client.dart';

import '../../../client.dart';

abstract class MatchmakerRepository {
  Future<CollabMatch> generatePitch({
    required int devOneId,
    required int devTwoId,
  });
}

class ServerpodMatchmakerRepository implements MatchmakerRepository {
  @override
  Future<CollabMatch> generatePitch({
    required int devOneId,
    required int devTwoId,
  }) async {
    return await client.match.generatePitch(
      devOneId: devOneId,
      devTwoId: devTwoId,
    );
  }
}
