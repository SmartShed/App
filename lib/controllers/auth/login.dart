import '../../models/user.dart';
import '../../utils/api/auth.dart';
import '../../utils/cache/user.dart';
import '../../utils/cache/xauth_token.dart';
import '../logger/log.dart';
import 'google_sign_in.dart';

class LoginController {
  static final _logger = LoggerService.getLogger('LoginController');
  static final AuthAPIHandler _authAPIHandler = AuthAPIHandler();

  static bool validatedToken = false;

  static Future<void> init() async {
    await XAuthTokenCacheHandler.init();
    await UserCacheHandler.init();
    await validateToken();
  }

  static Future<Map<String, dynamic>?> login(
      String email, String password) async {
    _logger.info('Logging in with email and password');
    Map<String, dynamic> response =
        await _authAPIHandler.login(email, password);

    if (response['status'] == 'success') {
      XAuthTokenCacheHandler.saveToken(response['auth_token']);

      UserCacheHandler.saveUserFromJson(response['user']);
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
      XAuthTokenCacheHandler.saveToken(response['auth_token']);
      UserCacheHandler.saveUserFromJson(response['user']);
    } else {
      _logger.error('Login with Google failed');
    }

    return response;
  }

  static Future<bool> logout() async {
    try {
      _logger.info('Logging out');
      Map<String, dynamic> response =
          await _authAPIHandler.logout(XAuthTokenCacheHandler.token!);

      if (response['status'] != 'success') {
        _logger.error('Logout failed');
        return false;
      }

      await XAuthTokenCacheHandler.deleteToken();
      await UserCacheHandler.deleteUser();

      await GoogleSignInAPI.signOut();

      return true;
    } catch (e) {
      _logger.error(e);
      _logger.error('Logout failed');
      return false;
    }
  }

  static Future<bool> get isLoggedIn async {
    if (!(await XAuthTokenCacheHandler.hasToken)) return false;
    return await validateToken();
  }

  static Future<bool> validateToken() async {
    if (validatedToken) return true;

    try {
      Map<String, dynamic> response =
          await _authAPIHandler.validateToken(XAuthTokenCacheHandler.token!);

      if (response['status'] != 'success') {
        _logger.error('Token is invalid');
        return false;
      }

      validatedToken = response['data']['isAuthTokenValid'];
      return response['data']['isAuthTokenValid'];
    } catch (e) {
      _logger.error(e);
      _logger.error('Token is invalid');
      return false;
    }
  }

  static String? get token => XAuthTokenCacheHandler.token;

  static SmartShedUser? get user => UserCacheHandler.user;

  static bool get isWorker => user != null && user!.position == 'worker';

  static bool get isSupervisor =>
      user != null && user!.position == 'supervisor';

  static bool get isAuthority => user != null && user!.position == 'authority';
}
