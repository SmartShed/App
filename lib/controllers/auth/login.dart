import '../../utils/api/auth.dart';
import '../../utils/cache/xauth_token.dart';
import './google_sign_in.dart';
import '../logger/log.dart';

class LoginController {
  static final AuthAPIHandler _authAPIHandler = AuthAPIHandler();
  static final _logger = LoggerService.getLogger('LoginController');

  static Future<void> init() async {
    await XAuthTokenHandler.init();
  }

  static Future<Map<String, dynamic>?> login(
      String email, String password) async {
    _logger.info('Logging in with email and password');
    Map<String, dynamic> response =
        await _authAPIHandler.login(email, password);

    if (response['status'] == 'success') {
      XAuthTokenHandler.saveToken(response['auth_token']);
    } else {
      _logger.error('Login failed');
    }

    return response;
  }

  static Future<Map<String, dynamic>?> loginWithGoogle() async {
    _logger.info('Logging in with Google');
    final account = await GoogleSignInAPI.signIn();

    if (account == null) {
      _logger.error('Google sign-in failed');
      return {
        'status': 'error',
        'message': 'Something went wrong. Please try again later.',
      };
    }

    Map<String, dynamic> response =
        await _authAPIHandler.loginWithGoogle(account.email);

    if (response['status'] == 'success') {
      XAuthTokenHandler.saveToken(response['auth_token']);
    } else {
      _logger.error('Login with Google failed');
    }

    return response;
  }

  static Future<bool> logout() async {
    try {
      _logger.info('Logging out');
      Map<String, dynamic> response =
          await _authAPIHandler.logout(XAuthTokenHandler.token!);

      if (response['status'] != 'success') {
        _logger.error('Logout failed');
        return false;
      }

      await XAuthTokenHandler.deleteToken();

      await GoogleSignInAPI.signOut();

      return true;
    } catch (e) {
      _logger.error('Logout failed');
      return false;
    }
  }

  static Future<bool> get isLoggedIn async {
    return XAuthTokenHandler.hasToken;
  }

  static String? get token => XAuthTokenHandler.token;
}
