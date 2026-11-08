import 'package:flutter/foundation.dart';

import '../../data/registration_repository.dart';
import 'registration_state.dart';

class RegistrationController extends ValueNotifier<RegistrationState> {
  final RegistrationRepository _repository;

  RegistrationController({RegistrationRepository? repository})
      : _repository = repository ?? ServerpodRegistrationRepository(),
        super(const RegistrationState());

  Future<bool> submitCard({
    required String name,
    required String role,
    required String skillsRaw,
    required String interests,
    String? githubHandle,
  }) async {
    value = value.copyWith(
      status: RegistrationStatus.loading,
      errorMessage: null,
    );

    try {
      final skills = skillsRaw
          .split(RegExp(r'[,|]'))
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      final profile = await _repository.registerCard(
        name: name.trim(),
        role: role.trim(),
        skills: skills,
        interests: interests.trim(),
        githubHandle: githubHandle?.replaceAll('@', '').trim(),
      );

      value = value.copyWith(
        status: RegistrationStatus.success,
        createdProfile: profile,
      );
      return true;
    } catch (e) {
      value = value.copyWith(
        status: RegistrationStatus.failure,
        errorMessage: e.toString().replaceAll('Exception:', '').trim(),
      );
      return false;
    }
  }

  void reset() {
    value = const RegistrationState();
  }
}
