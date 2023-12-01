import '../../utils/api/auth.dart';
import '../../utils/cache/xauth_token.dart';
import './google_sign_in.dart';
import '../logger/log.dart';

class RegisterController {
  static final AuthAPIHandler _authAPIHandler = AuthAPIHandler();
  static final _logger = LoggerService.getLogger('RegisterController');

  static Future<void> init() async {
    await XAuthTokenHandler.init();
    _logger.info('RegisterController initialized');
  }

  static Future<Map<String, dynamic>?> register(
      String email, String password, String name, String position) async {
    _logger.info('Registering user: $email');
    Map<String, dynamic> response =
        await _authAPIHandler.register(email, password, name, position);

    if (response['status'] == 'success') {
      XAuthTokenHandler.saveToken(response['auth_token']);
      _logger.info('User registered successfully: $email');
    } else {
      _logger.error('Failed to register user: $email');
    }

    return response;
  }

  static Future<Map<String, dynamic>?> registerWithGoogle(
      String email, String name, String position) async {
    _logger.info('Registering user with Google: $email');
    Map<String, dynamic> response =
        await _authAPIHandler.registerWithGoogle(email, name, position);

    if (response['status'] == 'success') {
      XAuthTokenHandler.saveToken(response['auth_token']);
      _logger.info('User registered with Google successfully: $email');
    } else {
      _logger.error('Failed to register user with Google: $email');
    }

    return response;
  }

  static Future<Map<String, dynamic>?> showGoogleSignInDialog() async {
    _logger.info('Showing Google sign in dialog');
    final account = await GoogleSignInAPI.signIn();
    if (account == null) {
      _logger.info('User canceled Google sign in');
      return null;
    }
    _logger.info('User signed in with Google: ${account.email}');
    return {
      "name": account.displayName ?? "",
      "email": account.email,
    };
  }
}
