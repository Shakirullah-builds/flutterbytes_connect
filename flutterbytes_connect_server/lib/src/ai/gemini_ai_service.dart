import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'ai_service.dart';

/// Gemini REST implementation utilizing `gemini-2.5-flash`.
class GeminiAiService implements AiService {
  final String? _apiKey;
  final http.Client _client;

  GeminiAiService({String? apiKey, http.Client? client})
      : _apiKey = apiKey ?? Platform.environment['GEMINI_API_KEY'],
        _client = client ?? http.Client();

  static const String _model = 'gemini-2.5-flash';
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/$_model:generateContent';

  @override
  Future<PersonaResult> generatePersona({
    required String name,
    required String role,
    required List<String> skills,
    required String interests,
  }) async {
    if (_apiKey == null || _apiKey.trim().isEmpty) {
      return _fallbackPersona(name, role, skills, interests);
    }

    final prompt = '''
You are the official MC at the FlutterBytes AI Conference.
A developer just registered:
- Name: $name
- Role: $role
- Skills: ${skills.join(', ')}
- Interests / Idea: $interests

Generate a creative, tech-savvy persona card for this developer.
Return ONLY valid JSON matching this exact structure:
{
  "personaTitle": "3-4 word catchy title (e.g. The Reactive State Wizard, The Shimmer UI Alchemist, The Fullstack Maestro)",
  "bioHook": "1 crisp, punchy sentence summarizing what they build or love (e.g. Crafting butter-smooth 120fps animations with a passion for offline-first architecture.)"
}
''';

    try {
      final responseBody = await _callGemini(prompt);
      final jsonMap = jsonDecode(responseBody) as Map<String, dynamic>;
      final personaTitle = jsonMap['personaTitle'] as String? ?? 'Flutter Craftsman';
      final bioHook = jsonMap['bioHook'] as String? ??
          'Passionate developer building high-performance Flutter applications.';

      return PersonaResult(
        personaTitle: personaTitle.trim(),
        bioHook: bioHook.trim(),
      );
    } catch (e) {
      return _fallbackPersona(name, role, skills, interests);
    }
  }

  @override
  Future<CollabResult> generateCollabPitch({
    required AttendeeProfile devOne,
    required AttendeeProfile devTwo,
  }) async {
    if (_apiKey == null || _apiKey.trim().isEmpty) {
      return _fallbackCollab(devOne, devTwo);
    }

    final prompt = '''
You are the AI Matchmaker at FlutterBytes Conference.
Two developers want to build a hackathon project together:

Developer 1:
- Name: ${devOne.name}
- Role: ${devOne.role}
- Persona: ${devOne.personaTitle}
- Skills: ${devOne.skills.join(', ')}
- Interests: ${devOne.interests}

Developer 2:
- Name: ${devTwo.name}
- Role: ${devTwo.role}
- Persona: ${devTwo.personaTitle}
- Skills: ${devTwo.skills.join(', ')}
- Interests: ${devTwo.interests}

Invent an innovative, exciting 24-hour hackathon project using Flutter and Serverpod that merges both developers' strengths.
Return ONLY valid JSON matching this exact structure:
{
  "projectTitle": "Catchy 2-3 word project name (e.g. AgroStream AI, PulseLedger, SoundBridge)",
  "tagline": "1-sentence elevator pitch explaining what the app does and why it solves a real problem.",
  "devOneResponsibility": "1 concise sentence defining what ${devOne.name} builds.",
  "devTwoResponsibility": "1 concise sentence defining what ${devTwo.name} builds."
}
''';

    try {
      final responseBody = await _callGemini(prompt);
      final jsonMap = jsonDecode(responseBody) as Map<String, dynamic>;

      return CollabResult(
        projectTitle: jsonMap['projectTitle'] as String? ?? 'ByteSync Project',
        tagline: jsonMap['tagline'] as String? ??
            'A modern full-stack Flutter application powered by Serverpod.',
        devOneResponsibility: jsonMap['devOneResponsibility'] as String? ??
            'Lead frontend architecture and reactive UI implementation.',
        devTwoResponsibility: jsonMap['devTwoResponsibility'] as String? ??
            'Develop Serverpod endpoints, database models, and real-time streams.',
      );
    } catch (e) {
      return _fallbackCollab(devOne, devTwo);
    }
  }

  Future<String> _callGemini(String prompt) async {
    final uri = Uri.parse('$_baseUrl?key=$_apiKey');
    final payload = {
      'contents': [
        {
          'parts': [
            {'text': prompt}
          ]
        }
      ],
      'generationConfig': {
        'responseMimeType': 'application/json',
        'temperature': 0.7,
      },
    };

    final response = await _client
        .post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(payload),
        )
        .timeout(const Duration(seconds: 12));

    if (response.statusCode != 200) {
      throw HttpException(
        'Gemini API error (${response.statusCode}): ${response.body}',
      );
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final candidates = decoded['candidates'] as List<dynamic>?;
    if (candidates == null || candidates.isEmpty) {
      throw const FormatException('No candidates returned by Gemini');
    }

    final firstCandidate = candidates.first as Map<String, dynamic>;
    final content = firstCandidate['content'] as Map<String, dynamic>?;
    final parts = content?['parts'] as List<dynamic>?;
    final text = parts?.first?['text'] as String?;

    if (text == null || text.trim().isEmpty) {
      throw const FormatException('Empty text content received from Gemini');
    }

    return text.trim();
  }

  PersonaResult _fallbackPersona(
    String name,
    String role,
    List<String> skills,
    String interests,
  ) {
    final primarySkill = skills.isNotEmpty ? skills.first : 'Flutter';
    final personaTitle = '$primarySkill Architect';
    final bioHook =
        'Specializing in $role with a strong focus on $interests.';

    return PersonaResult(
      personaTitle: personaTitle,
      bioHook: bioHook,
    );
  }

  CollabResult _fallbackCollab(
    AttendeeProfile devOne,
    AttendeeProfile devTwo,
  ) {
    return CollabResult(
      projectTitle: 'FlutterBytes Collab Hub',
      tagline:
          'A collaborative mobile application combining ${devOne.role} and ${devTwo.role} to innovate at FlutterBytes.',
      devOneResponsibility:
          '${devOne.name} orchestrates the Flutter client architecture and component design.',
      devTwoResponsibility:
          '${devTwo.name} designs Serverpod data pipelines, business logic, and backend storage.',
    );
  }
}
