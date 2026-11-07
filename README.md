# FlutterBytes Connect AI

A real-time developer networking wall and AI hackathon team matchmaker built for the **FlutterBytes Conference 2026** (Day 2 live demo).

Live App: [https://flutterbytes-connect.serverpod.space/](https://flutterbytes-connect.serverpod.space/)  
Live API: [https://flutterbytes-connect.api.serverpod.space/](https://flutterbytes-connect.api.serverpod.space/)

---

## What It Does

Conferences often suffer from the "hallway track problem": hundreds of engineers are in the same room, but it's hard to quickly find people building with the same tech stack, or teammates with complementary skills for the hackathon.

FlutterBytes Connect solves this with an interactive, live-updating engineering wall:

1. **Claim Your Card**: Attendees fill out a fast form with their name, role, bio, and key technologies (Flutter, Serverpod, Riverpod, Python, Supabase, etc.).
2. **AI Persona Synthesis**: Google Gemini 3.8 Flash analyzes the attendee's profile on submission and assigns an engineering title and archetype (e.g., *"Node.js TypeScript Architect"*, *"Flutter Architect"*) that captures what they actually build.
3. **Real-Time Streaming Wall**: New attendee cards appear instantly across every connected browser tab using Serverpod's streaming WebSocket connections without page refreshes or polling.
4. **Hackathon Team Synergy**: Tap **Collaborate** on any two engineers to have Gemini compare their skill sets and generate an instant hackathon concept, tech stack recommendation, and why the pair works well together.

---

## Architecture & Tech Stack

This project is 100% Dart end-to-end:

```
[ Flutter Web Frontend ]
        │  ▲
        │  │ WebSockets / Serverpod Streaming Connection
        ▼  │
[ Serverpod 4.1 Server ]  ◄───►  [ PostgreSQL Database ]
        │
        ▼  JSON-mode prompt with fallback resilience
[ Google Gemini 3.8 Flash API ]
```

- **Frontend**: Flutter Web (CanvasKit/HTML renderer) with custom dark-mode theme, frosted glass floating navbar, and responsive mobile-to-desktop grid.
- **Backend**: [Serverpod 4.1](https://serverpod.dev) running on Dart, hosted on Serverpod Cloud.
- **Streaming**: Serverpod message passing channels broadcast new attendee registrations and presence counts to all connected clients in real time.
- **AI Engine**: Google Gemini 3.8 Flash (with automatic cascading fallbacks to 3.5-flash-lite and exponential backoff retry for rate spikes).
- **Database**: PostgreSQL managed by Serverpod ORM and migrations.

---

## Repository Structure

```
flutterbytes_connect/
├── flutterbytes_connect_server/   # Serverpod backend & endpoints
│   ├── lib/src/ai/               # Gemini AI prompt engine & JSON parsers
│   ├── lib/src/endpoints/        # Attendee and collaboration streaming endpoints
│   └── lib/src/models/           # YAML model schemas
├── flutterbytes_connect_client/   # Generated Dart client library
└── flutterbytes_connect_flutter/  # Flutter Web client application
    ├── assets/images/            # Official FlutterBytes Conference branding
    ├── lib/features/wall/        # Live wall UI, cards, and floating navbar
    └── lib/features/claim_card/  # Profile submission modal & validation
```

---

## Getting Started Locally

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.22+ recommended)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- [Serverpod CLI](https://docs.serverpod.dev/get-started):
  ```bash
  dart pub global activate serverpod_cli
  ```
- [Docker Desktop](https://www.docker.com/) (for local Postgres database)
- Google Gemini API key from [Google AI Studio](https://aistudio.google.com/)

---

### 1. Start the Database and Backend

```bash
cd flutterbytes_connect_server

# 1. Start local PostgreSQL via Docker
docker compose up -d

# 2. Set your Gemini API key in config/passwords.yaml or as an environment variable
# config/passwords.yaml:
#   development:
#     geminiApiKey: 'YOUR_GEMINI_API_KEY'

# 3. Apply database migrations
serverpod create-migration
dart bin/main.dart --apply-migrations

# 4. Start the server
dart bin/main.dart
```

The Serverpod server runs on `http://localhost:8080` (API) and `http://localhost:8081` (Web server / insights).

---

### 2. Start the Flutter Web Client

In another terminal:

```bash
cd flutterbytes_connect_flutter

# Install dependencies
flutter pub get

# Run on Chrome
flutter run -d chrome
```

The web client automatically connects to `http://localhost:8080` when running locally, and switches to `https://flutterbytes-connect.api.serverpod.space` when loaded from the cloud domain.

---

### 3. Running Server Tests

The backend includes test coverage for Gemini AI parsing, JSON fence-stripping, and fallback handling:

```bash
cd flutterbytes_connect_server
dart test test/unit/gemini_ai_service_test.dart
```

---

## Deploying to Serverpod Cloud

1. Build the Flutter Web bundle into the server's public web directory:
   ```bash
   cd flutterbytes_connect_flutter
   flutter build web --base-href / --output ../flutterbytes_connect_server/web/app
   ```

2. Set production passwords/secrets:
   ```bash
   cd ../flutterbytes_connect_server
   scloud secret set geminiApiKey "YOUR_API_KEY"
   ```

3. Deploy:
   ```bash
   scloud deploy
   ```

---

## Built For

FlutterBytes Conference 2026  
Created with Dart, Flutter, Serverpod, and Google Gemini.
