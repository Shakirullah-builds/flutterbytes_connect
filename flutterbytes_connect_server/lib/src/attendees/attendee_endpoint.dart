import 'package:serverpod/serverpod.dart';

import '../ai/ai_service.dart';
import '../ai/gemini_ai_service.dart';
import '../constants/channels.dart';
import '../generated/protocol.dart';

/// Serverpod endpoint managing attendee profiles and real-time live wall feeds.
class AttendeeEndpoint extends Endpoint {
  final AiService _aiService;

  AttendeeEndpoint({AiService? aiService})
      : _aiService = aiService ?? GeminiAiService();

  /// Creates a new attendee profile, synthesizes an AI persona, saves to DB,
  /// and broadcasts the new card to all connected live wall clients.
  Future<AttendeeProfile> createProfile(
    Session session, {
    required String name,
    required String role,
    required List<String> skills,
    required String interests,
    String? githubHandle,
  }) async {
    final sanitizedName = name.trim();
    final sanitizedRole = role.trim();
    final sanitizedInterests = interests.trim();
    final sanitizedGithub = githubHandle?.trim();
    final cleanSkills = skills
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    if (sanitizedName.isEmpty) {
      throw ArgumentError('Name cannot be empty.');
    }
    if (sanitizedName.length > 60) {
      throw ArgumentError('Name must be 60 characters or fewer.');
    }
    if (sanitizedRole.isEmpty) {
      throw ArgumentError('Role cannot be empty.');
    }
    if (cleanSkills.isEmpty) {
      throw ArgumentError('At least one skill is required.');
    }
    if (sanitizedInterests.isEmpty) {
      throw ArgumentError('Interests / project idea cannot be empty.');
    }

    // Synthesize developer persona with Gemini AI
    final persona = await _aiService.generatePersona(
      name: sanitizedName,
      role: sanitizedRole,
      skills: cleanSkills,
      interests: sanitizedInterests,
    );

    // Compute a stable avatar seed based on the attendee name
    final avatarSeed = sanitizedName.hashCode.abs() % 1000;

    final profile = AttendeeProfile(
      name: sanitizedName,
      role: sanitizedRole,
      skills: cleanSkills,
      interests: sanitizedInterests,
      githubHandle: (sanitizedGithub != null && sanitizedGithub.isNotEmpty)
          ? sanitizedGithub
          : null,
      personaTitle: persona.personaTitle,
      bioHook: persona.bioHook,
      avatarSeed: avatarSeed,
      createdAt: DateTime.now(),
    );

    // Persist to PostgreSQL database
    final savedProfile = await AttendeeProfile.db.insertRow(session, profile);

    // Broadcast in real-time to all clients subscribed to the live wall
    await session.messages.postMessage(
      ChannelConstants.wallChannel,
      savedProfile,
    );

    return savedProfile;
  }

  /// Fetches attendee profiles ordered by newest first.
  Future<List<AttendeeProfile>> getProfiles(
    Session session, {
    int limit = 50,
    int offset = 0,
  }) async {
    return await AttendeeProfile.db.find(
      session,
      orderBy: (t) => t.createdAt.desc(),
      limit: limit,
      offset: offset,
    );
  }

  /// Modern Serverpod 4 method stream: yields new profiles as they are created.
  Stream<AttendeeProfile> watchProfiles(Session session) async* {
    yield* session.messages.createStream<AttendeeProfile>(
      ChannelConstants.wallChannel,
    );
  }
}
