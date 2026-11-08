import 'package:serverpod/serverpod.dart';

import '../ai/ai_service.dart';
import '../ai/gemini_ai_service.dart';
import '../generated/protocol.dart';

/// Serverpod endpoint managing collaborative matchmaking between attendees.
class MatchEndpoint extends Endpoint {
  final AiService _aiService;

  MatchEndpoint({AiService? aiService})
      : _aiService = aiService ?? GeminiAiService();

  /// Generates an AI-powered hackathon project synergy between two attendees.
  Future<CollabMatch> generatePitch(
    Session session, {
    required int devOneId,
    required int devTwoId,
  }) async {
    if (devOneId == devTwoId) {
      throw ArgumentError('Cannot match an attendee with themselves.');
    }

    // Retrieve both developer profiles from the database
    final devOne = await AttendeeProfile.db.findById(session, devOneId);
    final devTwo = await AttendeeProfile.db.findById(session, devTwoId);

    if (devOne == null || devTwo == null) {
      throw ArgumentError('One or both developer profiles could not be found.');
    }

    // Call Gemini to synthesize a project idea based on their specific skills
    final pitch = await _aiService.generateCollabPitch(
      devOne: devOne,
      devTwo: devTwo,
    );

    final match = CollabMatch(
      devOneId: devOne.id!,
      devTwoId: devTwo.id!,
      devOneName: devOne.name,
      devTwoName: devTwo.name,
      projectTitle: pitch.projectTitle,
      tagline: pitch.tagline,
      devOneResponsibility: pitch.devOneResponsibility,
      devTwoResponsibility: pitch.devTwoResponsibility,
      createdAt: DateTime.now(),
    );

    // Persist the match to the database
    return await CollabMatch.db.insertRow(session, match);
  }

  /// Retrieves recent collaborative matches.
  Future<List<CollabMatch>> getRecentMatches(
    Session session, {
    int limit = 20,
  }) async {
    return await CollabMatch.db.find(
      session,
      orderBy: (t) => t.createdAt.desc(),
      limit: limit,
    );
  }
}
