import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutterbytes_connect_client/flutterbytes_connect_client.dart';

import '../../data/wall_repository.dart';
import 'wall_state.dart';

class WallController extends ValueNotifier<WallState> {
  final WallRepository _repository;
  StreamSubscription<AttendeeProfile>? _streamSub;

  WallController({WallRepository? repository})
      : _repository = repository ?? ServerpodWallRepository(),
        super(const WallState()) {
    init();
  }

  Future<void> init() async {
    value = value.copyWith(isLoading: true, errorMessage: null);

    try {
      final initialProfiles = await _repository.fetchProfiles();
      value = value.copyWith(
        isLoading: false,
        allProfiles: initialProfiles,
      );

      _listenToLiveStream();
    } catch (e) {
      value = value.copyWith(
        isLoading: false,
        errorMessage: 'Unable to connect to Serverpod Live Stream: $e',
      );
    }
  }

  void _listenToLiveStream() {
    _streamSub?.cancel();
    try {
      _streamSub = _repository.watchProfiles().listen(
        (newProfile) {
          if (newProfile.id == -1 || newProfile.name == '__WALL_RESET__') {
            // Live broadcast from presenter reset: wipe cards on all connected screens
            value = value.copyWith(allProfiles: []);
            return;
          }

          final current = List<AttendeeProfile>.from(value.allProfiles);
          final existingIndex = current.indexWhere((p) => p.id == newProfile.id);

          if (existingIndex == -1) {
            // New card published live! Prepend to the top of the wall
            current.insert(0, newProfile);
            value = value.copyWith(allProfiles: current);
          }
        },
        onError: (err) {
          // Automatic reconnect on network interruption
          Future.delayed(const Duration(seconds: 4), () {
            if (!_isDisposed) _listenToLiveStream();
          });
        },
      );
    } catch (_) {
      // Stream fallback handling
    }
  }

  /// Presenter reset: returns true if reset succeeded, false if passcode was incorrect
  Future<bool> resetWall(String adminPassword) async {
    try {
      final success = await _repository.resetWall(adminPassword.trim());
      if (success) {
        value = value.copyWith(allProfiles: []);
      }
      return success;
    } catch (_) {
      return false;
    }
  }

  void setFilter(String filter) {
    value = value.copyWith(selectedFilter: filter);
  }

  void setSearchQuery(String query) {
    value = value.copyWith(searchQuery: query);
  }

  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    _streamSub?.cancel();
    super.dispose();
  }
}
