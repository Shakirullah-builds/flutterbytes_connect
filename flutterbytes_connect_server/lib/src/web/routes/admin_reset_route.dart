import 'package:serverpod/serverpod.dart';

import '../../constants/channels.dart';
import '../../generated/protocol.dart';

/// HTTP route allowing authenticated presenter reset via URL:
/// GET /admin/reset?key=<configuredPin>
class AdminResetRoute extends WidgetRoute {
  @override
  Future<WebWidget> build(Session session, Request request) async {
    final key = request.url.queryParameters['key'];
    final configuredPin = session.serverpod.getPassword('adminResetPin');

    if (configuredPin == null || configuredPin.isEmpty || key?.trim() != configuredPin.trim()) {
      return JsonWidget(object: {
        'status': 'error',
        'message': 'Invalid presenter key.',
      });
    }

    try {
      await CollabMatch.db.deleteWhere(session, where: (t) => Constant.bool(true));
      await AttendeeProfile.db.deleteWhere(session, where: (t) => Constant.bool(true));

      final resetSentinel = AttendeeProfile(
        id: -1,
        name: '__WALL_RESET__',
        role: '',
        skills: const [],
        interests: '',
        personaTitle: '',
        bioHook: '',
        avatarSeed: 0,
        createdAt: DateTime.now(),
      );

      await session.messages.postMessage(
        ChannelConstants.wallChannel,
        resetSentinel,
      );

      return JsonWidget(object: {
        'status': 'ok',
        'message': 'Demo reset complete. Database wiped clean for showcase.',
      });
    } catch (e) {
      return JsonWidget(object: {
        'status': 'error',
        'message': 'Error resetting wall: $e',
      });
    }
  }
}
