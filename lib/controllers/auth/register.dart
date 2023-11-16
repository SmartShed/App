import '../../utils/api/auth.dart';
import '../../utils/cache/xauth_token.dart';
import './google_sign_in.dart';

class RegisterController {
  static final AuthAPIHandler _authAPIHandler = AuthAPIHandler();

  static Future<void> init() async {
    await XAuthTokenHandler.init();
  }

  static Future<Map<String, dynamic>?> register(
      String email, String password, String name, String position) async {
    Map<String, dynamic> response =
        await _authAPIHandler.register(email, password, name, position);

    if (response['status'] == 'success') {
      XAuthTokenHandler.saveToken(response['auth_token']);
    }

    return response;
  }

  static Future<Map<String, dynamic>?> registerWithGoogle(
      String email, String name, String position) async {
    Map<String, dynamic> response =
        await _authAPIHandler.registerWithGoogle(email, name, position);

    if (response['status'] == 'success') {
      XAuthTokenHandler.saveToken(response['auth_token']);
    }

    return response;
  }

  // Show google sign in dialog and return the user json
  static Future<Map<String, dynamic>?> showGoogleSignInDialog() async {
    final account = await GoogleSignInAPI.signIn();
    if (account == null) {
      return null;
    }
    return {
      "name": account.displayName ?? "",
      "email": account.email,
    };
  }
}
