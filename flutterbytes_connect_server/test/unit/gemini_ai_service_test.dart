import 'dart:convert';

import 'package:flutterbytes_connect_server/src/ai/gemini_ai_service.dart';
import 'package:flutterbytes_connect_server/src/generated/protocol.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('GeminiAiService Unit Tests', () {
    test('generatePersona succeeds and parses plain JSON response using primary model (gemini-3.8-flash)', () async {
      final mockClient = MockClient((request) async {
        expect(request.url.queryParameters['key'], equals('test-api-key'));
        expect(request.url.path, contains('gemini-3.8-flash'));
        final responsePayload = {
          'candidates': [
            {
              'content': {
                'parts': [
                  {
                    'text': jsonEncode({
                      'personaTitle': 'The Reactive State Wizard',
                      'bioHook': 'Crafting butter-smooth 120fps animations with Serverpod streams.',
                    }),
                  }
                ],
              },
            }
          ],
        };
        return http.Response(jsonEncode(responsePayload), 200);
      });

      final service = GeminiAiService(apiKey: 'test-api-key', client: mockClient);
      final result = await service.generatePersona(
        name: 'Ada Lovelace',
        role: 'Systems Architect',
        skills: ['Dart', 'Serverpod', 'Flutter'],
        interests: 'High performance real-time apps',
      );

      expect(result.personaTitle, equals('The Reactive State Wizard'));
      expect(result.bioHook, equals('Crafting butter-smooth 120fps animations with Serverpod streams.'));
    });

    test('generatePersona handles markdown code fences (```json ... ```) without crashing', () async {
      final mockClient = MockClient((request) async {
        final rawTextWithMarkdown = '''
```json
{
  "personaTitle": "The Shimmer UI Alchemist",
  "bioHook": "Obsessed with pixel-perfect layouts and offline-first state machines."
}
```
''';
        final responsePayload = {
          'candidates': [
            {
              'content': {
                'parts': [
                  {'text': rawTextWithMarkdown}
                ],
              },
            }
          ],
        };
        return http.Response(jsonEncode(responsePayload), 200);
      });

      final service = GeminiAiService(apiKey: 'test-api-key', client: mockClient);
      final result = await service.generatePersona(
        name: 'Chioma Adeyemi',
        role: 'Lead Mobile Engineer',
        skills: ['Flutter', 'Riverpod'],
        interests: 'HealthTech apps',
      );

      expect(result.personaTitle, equals('The Shimmer UI Alchemist'));
      expect(result.bioHook, equals('Obsessed with pixel-perfect layouts and offline-first state machines.'));
    });

    test('generatePersona retries on 503 high demand spike and succeeds on second attempt', () async {
      var callCount = 0;
      final mockClient = MockClient((request) async {
        callCount++;
        if (callCount == 1) {
          // 503 spike
          return http.Response('{"error": {"code": 503, "message": "High demand spike"}}', 503);
        }
        // Second attempt succeeds
        final responsePayload = {
          'candidates': [
            {
              'content': {
                'parts': [
                  {
                    'text': jsonEncode({
                      'personaTitle': 'The Async Orchestrator',
                      'bioHook': 'Building resilient fault-tolerant distributed Dart backends.',
                    }),
                  }
                ],
              },
            }
          ],
        };
        return http.Response(jsonEncode(responsePayload), 200);
      });

      final service = GeminiAiService(apiKey: 'test-api-key', client: mockClient);
      final result = await service.generatePersona(
        name: 'Tunde Bakare',
        role: 'Cloud Architect',
        skills: ['Serverpod', 'Dart', 'Docker'],
        interests: 'Distributed systems',
      );

      expect(callCount, equals(2));
      expect(result.personaTitle, equals('The Async Orchestrator'));
    });

    test('generatePersona automatically falls back to secondary candidate model if primary fails', () async {
      final mockClient = MockClient((request) async {
        if (request.url.path.contains('gemini-3.8-flash')) {
          // Primary model unavailable
          return http.Response('{"error": {"code": 503, "message": "Unavailable"}}', 503);
        }
        // Secondary model (gemini-3.5-flash-lite) succeeds
        final responsePayload = {
          'candidates': [
            {
              'content': {
                'parts': [
                  {
                    'text': jsonEncode({
                      'personaTitle': 'The Flutter Alchemist',
                      'bioHook': 'Turning coffee into slick animations.',
                    }),
                  }
                ],
              },
            }
          ],
        };
        return http.Response(jsonEncode(responsePayload), 200);
      });

      final service = GeminiAiService(apiKey: 'test-api-key', client: mockClient);
      final result = await service.generatePersona(
        name: 'Kofi Mensah',
        role: 'Frontend Lead',
        skills: ['Flutter', 'Dart'],
        interests: 'Animations',
      );

      expect(result.personaTitle, equals('The Flutter Alchemist'));
    });

    test('generateCollabPitch succeeds and parses pitch JSON', () async {
      final mockClient = MockClient((request) async {
        final responsePayload = {
          'candidates': [
            {
              'content': {
                'parts': [
                  {
                    'text': jsonEncode({
                      'projectTitle': 'PulseLedger AI',
                      'tagline': 'Real-time offline-first health record sync with Flutter and Serverpod.',
                      'devOneResponsibility': 'Architects local SQLite offline caching and reactive UI.',
                      'devTwoResponsibility': 'Builds Serverpod stream endpoints and PostgreSQL schema.',
                    }),
                  }
                ],
              },
            }
          ],
        };
        return http.Response(jsonEncode(responsePayload), 200);
      });

      final dev1 = AttendeeProfile(
        id: 1,
        name: 'Dev One',
        role: 'Mobile Dev',
        skills: ['Flutter'],
        interests: 'Health',
        personaTitle: 'UI Specialist',
        bioHook: 'Building fast apps',
        avatarSeed: 123,
        createdAt: DateTime.now(),
      );

      final dev2 = AttendeeProfile(
        id: 2,
        name: 'Dev Two',
        role: 'Backend Dev',
        skills: ['Serverpod'],
        interests: 'Cloud DB',
        personaTitle: 'Backend Maestro',
        bioHook: 'Scale everything',
        avatarSeed: 456,
        createdAt: DateTime.now(),
      );

      final service = GeminiAiService(apiKey: 'test-api-key', client: mockClient);
      final result = await service.generateCollabPitch(devOne: dev1, devTwo: dev2);

      expect(result.projectTitle, equals('PulseLedger AI'));
      expect(result.tagline, contains('Real-time offline-first'));
    });
  });
}
