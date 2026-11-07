import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'ai_service.dart';

/// Gemini REST implementation with robust model fallback, JSON extraction,
/// retry on demand spikes (503/429), and comprehensive logging.
class GeminiAiService implements AiService {
  final String? _explicitApiKey;
  final http.Client _client;

  GeminiAiService({String? apiKey, http.Client? client})
      : _explicitApiKey = apiKey,
        _client = client ?? http.Client();

  /// Primary modern models recommended by Google AI Studio, followed by low-latency lite fallbacks.
  static const List<String> _candidateModels = [
    'gemini-3.8-flash',
    'gemini-3.5-flash-lite',
    'gemini-3.6-flash',
    'gemini-3.5-flash',
  ];

  String? _resolveApiKey() {
    final explicit = _explicitApiKey;
    if (explicit != null && explicit.trim().isNotEmpty) {
      return explicit.trim();
    }
    final env = Platform.environment['GEMINI_API_KEY'];
    if (env != null && env.trim().isNotEmpty) {
      return env.trim();
    }
    try {
      final pwd = Serverpod.instance.getPassword('GEMINI_API_KEY') ??
          Serverpod.instance.getPassword('geminiApiKey');
      if (pwd != null && pwd.trim().isNotEmpty) {
        return pwd.trim();
      }
    } catch (_) {}
    return null;
  }

  void _log(String message) {
    stdout.writeln('[GeminiAiService] $message');
  }

  void _logError(String message) {
    stderr.writeln('[GeminiAiService] $message');
  }

  @override
  Future<PersonaResult> generatePersona({
    required String name,
    required String role,
    required List<String> skills,
    required String interests,
  }) async {
    final apiKey = _resolveApiKey();
    if (apiKey == null) {
      _logError('WARNING: No GEMINI_API_KEY found in environment or passwords. Using fallback persona.');
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
      _log('Requesting persona synthesis for "$name" ($role)...');
      final responseBody = await _callGemini(prompt, apiKey);
      final jsonMap = _extractJson(responseBody);
      final personaTitle = jsonMap['personaTitle'] as String? ?? 'Flutter Craftsman';
      final bioHook = jsonMap['bioHook'] as String? ??
          'Passionate developer building high-performance Flutter applications.';

      _log('Persona synthesized successfully: "$personaTitle"');
      return PersonaResult(
        personaTitle: personaTitle.trim(),
        bioHook: bioHook.trim(),
      );
    } catch (e, st) {
      _logError('generatePersona failed: $e\n$st');
      return _fallbackPersona(name, role, skills, interests);
    }
  }

  @override
  Future<CollabResult> generateCollabPitch({
    required AttendeeProfile devOne,
    required AttendeeProfile devTwo,
  }) async {
    final apiKey = _resolveApiKey();
    if (apiKey == null) {
      _logError('WARNING: No GEMINI_API_KEY found in environment or passwords. Using fallback collab.');
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
      _log('Requesting collab match between "${devOne.name}" and "${devTwo.name}"...');
      final responseBody = await _callGemini(prompt, apiKey);
      final jsonMap = _extractJson(responseBody);

      final result = CollabResult(
        projectTitle: jsonMap['projectTitle'] as String? ?? 'ByteSync Project',
        tagline: jsonMap['tagline'] as String? ??
            'A modern full-stack Flutter application powered by Serverpod.',
        devOneResponsibility: jsonMap['devOneResponsibility'] as String? ??
            'Lead frontend architecture and reactive UI implementation.',
        devTwoResponsibility: jsonMap['devTwoResponsibility'] as String? ??
            'Develop Serverpod endpoints, database models, and real-time streams.',
      );
      _log('Collab pitch synthesized: "${result.projectTitle}"');
      return result;
    } catch (e, st) {
      _logError('generateCollabPitch failed: $e\n$st');
      return _fallbackCollab(devOne, devTwo);
    }
  }

  Future<String> _callGemini(String prompt, String apiKey) async {
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

    String? lastError;

    for (final model in _candidateModels) {
      final uri = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey',
      );

      for (var attempt = 1; attempt <= 2; attempt++) {
        try {
          final response = await _client
              .post(
                uri,
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(payload),
              )
              .timeout(const Duration(seconds: 14));

          if (response.statusCode == 200) {
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

          lastError = 'HTTP ${response.statusCode} on model $model: ${response.body}';
          _logError('$model (attempt $attempt) returned status ${response.statusCode}: ${response.body}');

          // Spikes in demand (503 / 429): retry same model after short backoff
          if ((response.statusCode == 503 || response.statusCode == 429) && attempt < 2) {
            await Future.delayed(const Duration(milliseconds: 1200));
            continue;
          }

          // Permanent Auth error: abort immediately
          if (response.statusCode == 401 || response.statusCode == 403) {
            throw HttpException('Gemini API authentication failed (${response.statusCode}): ${response.body}');
          }

          // Otherwise (404, 400, or persistent 503): break attempt loop to try next model
          break;
        } catch (e) {
          if (e is HttpException && e.message.contains('authentication failed')) {
            rethrow;
          }
          lastError = 'Error with $model (attempt $attempt): $e';
          _logError('Call to $model (attempt $attempt) failed: $e');
          if (attempt < 2) {
            await Future.delayed(const Duration(milliseconds: 1000));
          }
        }
      }
    }

    throw HttpException('Gemini API call failed across all candidate models: $lastError');
  }

  Map<String, dynamic> _extractJson(String raw) {
    var text = raw.trim();

    // Strip markdown code fences (```json ... ``` or ``` ... ```)
    if (text.startsWith('```json')) {
      text = text.substring(7);
    } else if (text.startsWith('```')) {
      text = text.substring(3);
    }
    if (text.endsWith('```')) {
      text = text.substring(0, text.length - 3);
    }
    text = text.trim();

    try {
      return jsonDecode(text) as Map<String, dynamic>;
    } catch (_) {
      // Robust fallback: find outermost JSON object bounds
      final start = text.indexOf('{');
      final end = text.lastIndexOf('}');
      if (start != -1 && end != -1 && end > start) {
        final substring = text.substring(start, end + 1);
        return jsonDecode(substring) as Map<String, dynamic>;
      }
      rethrow;
    }
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
