import 'package:flutterbytes_connect_client/flutterbytes_connect_client.dart';

import '../../../client.dart';

abstract class WallRepository {
  Future<List<AttendeeProfile>> fetchProfiles({int limit = 50, int offset = 0});
  Stream<AttendeeProfile> watchProfiles();
}

class ServerpodWallRepository implements WallRepository {
  @override
  Future<List<AttendeeProfile>> fetchProfiles({int limit = 50, int offset = 0}) async {
    return await client.attendee.getProfiles(limit: limit, offset: offset);
  }

  @override
  Stream<AttendeeProfile> watchProfiles() {
    return client.attendee.watchProfiles();
  }
}
