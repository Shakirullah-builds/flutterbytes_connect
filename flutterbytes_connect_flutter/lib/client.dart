import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutterbytes_connect_client/flutterbytes_connect_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

/// Dynamically resolves the API server URL:
/// 1. `--dart-define=SERVER_URL=...` compile-time environment variable.
/// 2. If running on Web in production (`serverpod.space`), automatically routes
///    to the corresponding `.api.serverpod.space` API subdomain.
/// 3. Otherwise falls back to `getServerUrl()` (`assets/config.json` -> localhost:8080).
Future<String> resolveServerUrl() async {
  const envUrl = String.fromEnvironment('SERVER_URL');
  if (envUrl.isNotEmpty) {
    return envUrl;
  }

  if (kIsWeb) {
    final host = Uri.base.host;
    if (host.contains('serverpod.space')) {
      final apiHost = host.replaceFirst('.serverpod.space', '.api.serverpod.space');
      return 'https://$apiHost/';
    }
  }

  return await getServerUrl();
}

late final Client client;

Future<void> initializeClient() async {
  final url = await resolveServerUrl();
  client = Client(url)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  unawaited(client.auth.initialize());
}
