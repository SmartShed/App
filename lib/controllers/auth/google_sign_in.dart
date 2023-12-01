import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../logger/log.dart';

const String CLIENT_ID_IOS =
    "733510285262-g2o3upi13pbohg452f9esash3tlmf88s.apps.googleusercontent.com";

class GoogleSignInAPI {
  static final _logger = LoggerService.getLogger('GoogleSignInAPI');

  static GoogleSignIn _googleSignIn() {
    if (kIsWeb || Platform.isAndroid) {
      return GoogleSignIn(
        scopes: [
          'email',
        ],
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      return GoogleSignIn(
        clientId: CLIENT_ID_IOS,
        scopes: [
          'email',
        ],
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
