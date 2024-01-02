import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../env/env.dart';
import '../logger/log.dart';

class GoogleSignInAPI {
  static final _logger = LoggerService.getLogger('GoogleSignInAPI');

  static GoogleSignIn _googleSignIn() {
    if (kIsWeb || Platform.isAndroid) {
      return GoogleSignIn(
        scopes: ['email'],
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      return GoogleSignIn(
        clientId: Env.googleSignInClientId,
        scopes: ['email'],
      );
    } else {
      return GoogleSignIn();
    }
  }

  static Future<GoogleSignInAccount?> signIn() {
    _logger.info('Signing in with Google');
    return _googleSignIn().signIn();
  }

  static Future<void> signOut() {
    _logger.info('Signing out from Google');
    return _googleSignIn().signOut();
  }

  static Future<void> disconnect() {
    _logger.info('Disconnecting from Google');
    return _googleSignIn().disconnect();
  }
}
