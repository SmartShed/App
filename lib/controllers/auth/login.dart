import '../../utils/api/auth.dart';
import '../../utils/cache/xauth_token.dart';
import './google_sign_in.dart';

/// The `LoginController` class handles the authentication and login functionality in the application.
///
/// It provides methods to perform login with email and password, login with Google, and logout.
/// The class also provides getters to check if the user is logged in and to get the authentication token.
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

  /// Logs out the user.
  ///
  /// This method logs out the user by performing the following steps:
  /// 1. Calls the `_authAPIHandler.logout` method with the user's token to log out from the server.
  /// 2. Deletes the user's token by calling the `XAuthTokenHandler.deleteToken` method.
  /// 3. If the user is logged in with Google, it calls the `GoogleSignInAPI.signOut` method to log out from Google.
  ///
  /// Returns `true` if the logout process is successful, otherwise returns `false`.
  static Future<bool> logout() async {
    try {
      Map<String, dynamic> response =
          await _authAPIHandler.logout(XAuthTokenHandler.token!);

      if (response['status'] != 'success') {
        return false;
      }

      await XAuthTokenHandler.deleteToken();

      await GoogleSignInAPI.signOut();

      return true;
    } catch (e) {
      return false;
    }
  }

  static bool get isLoggedIn => XAuthTokenHandler.hasToken;

  static String? get token => XAuthTokenHandler.token;
}
