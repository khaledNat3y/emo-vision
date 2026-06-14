// lib/core/services/deep_link_service.dart

import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:facial_emotional_detection_graduation_project/core/helpers/logger.dart';
import 'package:facial_emotional_detection_graduation_project/core/routing/routes.dart';
import 'package:flutter/material.dart';

class DeepLinkService {
  static final _appLinks = AppLinks();
  static StreamSubscription? _sub;

  static Future<void> init(GlobalKey<NavigatorState> navigatorKey) async {
    // Cold start — app was closed when link was clicked
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleLink(initialLink, navigatorKey);
    }

    // Warm start — app already running
    _sub = _appLinks.uriLinkStream.listen((uri) {
      _handleLink(uri, navigatorKey);
    });
  }

  static void _handleLink(Uri uri, GlobalKey<NavigatorState> navigatorKey) {
    // ADD THIS
    Logger.debug('Deep link received: $uri');
    Logger.debug('Scheme: ${uri.scheme}');
    Logger.debug('Host: ${uri.host}');
    Logger.debug('Path: ${uri.path}');
    Logger.debug('Query: ${uri.queryParameters}');

    final host = uri.host;

    if (host == 'email-verified') {
      navigatorKey.currentState?.pushNamed(Routes.emailVerifiedScreen);
    } else if (host == 'update-password') {
      final code = uri.queryParameters['code'];
      navigatorKey.currentState?.pushNamed(
        Routes.updatePasswordScreen,
        // arguments: {'code': code},
      );
    }
  }

  static void dispose() {
    _sub?.cancel();
  }
}
