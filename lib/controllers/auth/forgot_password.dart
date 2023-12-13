import '../../utils/api/auth.dart';
import '../logger/log.dart';
import '../toast/toast.dart';

class ForgotPasswordController {
  static final AuthAPIHandler _authAPIHandler = AuthAPIHandler();
  static final _logger = LoggerService.getLogger('ForgotPasswordController');

  static Future<bool> sendOTP(String email) async {
    _logger.info('Sending OTP to $email');
    Map<String, dynamic> response = await _authAPIHandler.sendOTP(email);

    if (response['status'] == 'success') {
      _logger.info('OTP sent to $email');
      ToastController.success(response['message']);
      return true;
    } else {
      _logger.error('Sending OTP to $email failed');
      ToastController.error(response['message']);
      return false;
    }
  }

  static Future<bool> validateOTP(String email, String otp) async {
    _logger.info('Validating OTP for $email');
    Map<String, dynamic> response =
        await _authAPIHandler.validateOTP(email, otp);

    if (response['status'] == 'success') {
      _logger.info('OTP validated for $email');
      ToastController.success(response['message']);
      return true;
    } else {
      _logger.error('Validating OTP for $email failed');
      ToastController.error(response['message']);
      return false;
    }
  }

  static Future<bool> resetPassword(String email, String password) async {
    _logger.info('Resetting password for $email');
    Map<String, dynamic> response =
        await _authAPIHandler.resetPassword(email, password);

    if (response['status'] == 'success') {
      _logger.info('Password reset for $email');
      ToastController.success(response['message']);
      return true;
    } else {
      _logger.error('Resetting password for $email failed');
      ToastController.error(response['message']);
      return false;
    }
  }
}
