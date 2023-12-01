import '../toast/toast.dart';
import '../logger/log.dart';

class FormOpeningController {
  static final _logger = LoggerService.getLogger('FormOpeningController');

  static Future<void> init() async {
    _logger.info('Initializing FormOpeningController');
    // TODO: Add initialization logic here
  }

  /// Create a new form for the given formId, locoName and locoNumber.
  /// Should return the id of the created form
  static Future<String>? createForm(
      String formId, String locoName, String locoNumber) {
    if (locoName.isEmpty || locoNumber.isEmpty) {
      ToastController.error('Please fill all the fields');
      _logger.warning('Empty fields detected');
      return null;
    }

    _logger.info(
        'Creating form with formId: $formId, locoName: $locoName, locoNumber: $locoNumber');

    // TODO: Implement API call

    return Future.delayed(const Duration(seconds: 2), () {
      _logger.info('Form created successfully');
      return 'formId';
    });
  }
}
