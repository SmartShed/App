import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

const String CLIENT_ID_IOS =
    "733510285262-g2o3upi13pbohg452f9esash3tlmf88s.apps.googleusercontent.com";

class GoogleSignInAPI {
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

  static Future<GoogleSignInAccount?> signIn() => _googleSignIn().signIn();
}
