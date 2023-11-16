import '../../utils/api/auth.dart';
import '../../utils/cache/xauth_token.dart';
import './google_sign_in.dart';

class LoginController {
  static final AuthAPIHandler _authAPIHandler = AuthAPIHandler();

  static Future<void> init() async {
    await XAuthTokenHandler.init();
  }

  static Future<Map<String, dynamic>?> login(
      String email, String password) async {
    Map<String, dynamic> response =
        await _authAPIHandler.login(email, password);

    if (response['status'] == 'success') {
      XAuthTokenHandler.saveToken(response['auth_token']);
    }

    return response;
  }

  static Future<Map<String, dynamic>?> loginWithGoogle() async {
    final account = await GoogleSignInAPI.signIn();
    if (account == null) {
      return {
        'status': 'error',
        'message': 'Something went wrong. Please try again later.',
      };
    }

    Map<String, dynamic> response =
        await _authAPIHandler.loginWithGoogle(account.email);

    if (response['status'] == 'success') {
      XAuthTokenHandler.saveToken(response['auth_token']);
    }

    return response;
  }

  static Future<void> logout() async {
    await _authAPIHandler.logout(XAuthTokenHandler.token!);
    await XAuthTokenHandler.deleteToken();
  }

  static bool get isLoggedIn => XAuthTokenHandler.hasToken;

  static String? get token => XAuthTokenHandler.token;
}
