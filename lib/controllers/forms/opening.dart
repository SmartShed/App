import '../toast/toast.dart';
import '../logger/log.dart';
import '../../utils/api/forms_open.dart';

class FormOpeningController {
  static final _logger = LoggerService.getLogger('FormOpeningController');
  static final FormsOpeningAPIHandler _formsOpeningAPIHandler =
      FormsOpeningAPIHandler();

  static Future<void> init() async {
    _logger.info('Initializing FormOpeningController');
  }

  static Future<String?> createForm(
      String formId, String locoName, String locoNumber) async {
    if (locoName.isEmpty || locoNumber.isEmpty) {
      ToastController.error('Please fill all the fields');
      _logger.warning('Empty fields detected');
      return null;
    }

    _logger.info(
        'Creating form with formId: $formId, locoName: $locoName, locoNumber: $locoNumber');

    final response =
        await _formsOpeningAPIHandler.createForm(formId, locoName, locoNumber);

    if (response['status'] == 'success') {
      ToastController.success(response['message']);
      return response['newFormID'];
    } else {
      ToastController.error(response['message']);
      return null;
    }
  }
}
