import 'package:flutterbytes_connect_client/flutterbytes_connect_client.dart';

import '../../../client.dart';

abstract class RegistrationRepository {
  Future<AttendeeProfile> registerCard({
    required String name,
    required String role,
    required List<String> skills,
    required String interests,
    String? githubHandle,
  });
}

class ServerpodRegistrationRepository implements RegistrationRepository {
  @override
  Future<AttendeeProfile> registerCard({
    required String name,
    required String role,
    required List<String> skills,
    required String interests,
    String? githubHandle,
  }) async {
    return await client.attendee.createProfile(
      name: name,
      role: role,
      skills: skills,
      interests: interests,
      githubHandle: githubHandle,
    );
  }
}
