import '../generated/protocol.dart';

/// Strongly-typed result of developer persona synthesis.
final class PersonaResult {
  final String personaTitle;
  final String bioHook;

  const PersonaResult({
    required this.personaTitle,
    required this.bioHook,
  });
}

/// Strongly-typed result of collaborative hackathon pitch generation.
final class CollabResult {
  final String projectTitle;
  final String tagline;
  final String devOneResponsibility;
  final String devTwoResponsibility;

  const CollabResult({
    required this.projectTitle,
    required this.tagline,
    required this.devOneResponsibility,
    required this.devTwoResponsibility,
  });
}

/// Abstract contract for AI operations.
abstract interface class AiService {
  /// Synthesizes a punchy title and bio hook for a developer profile.
  Future<PersonaResult> generatePersona({
    required String name,
    required String role,
    required List<String> skills,
    required String interests,
  });

  /// Synthesizes a collaborative project pitch between two developers.
  Future<CollabResult> generateCollabPitch({
    required AttendeeProfile devOne,
    required AttendeeProfile devTwo,
  });
}
