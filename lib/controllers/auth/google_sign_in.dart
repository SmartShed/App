import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

const String CLIENT_ID_IOS =
    "733510285262-g2o3upi13pbohg452f9esash3tlmf88s.apps.googleusercontent.com";

// class GoogleSignInAPI {
//   static final _googleSignIn = kIsWeb
//       ? GoogleSignIn(
//           clientId: CLIENT_ID,
//         )
//       : GoogleSignIn();

//   static Future<GoogleSignInAccount?> signIn() => _googleSignIn.signIn();
// }

// //Default definition
// GoogleSignIn googleSignIn = GoogleSignIn(
//   scopes: [
//     'email',
//   ],
// );

// //If current device is Web or Android, do not use any parameters except from scopes.
// if (kIsWeb || Platform.isAndroid ) {
//   googleSignIn = GoogleSignIn(
//     scopes: [
//       'email',
//     ],
//   );
// }

// //If current device IOS or MacOS, We have to declare clientID
// //Please, look STEP 2 for how to get Client ID for IOS
// if (Platform.isIOS || Platform.isMacOS) {
//   googleSignIn = GoogleSignIn(
//     clientId:
//         "YOUR_CLIENT_ID.apps.googleusercontent.com",
//     scopes: [
//       'email',
//     ],
//   );
// }

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
