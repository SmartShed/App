import '../../models/full_form.dart';
import '../../models/opened_form.dart';
import '../../utils/api/forms_open.dart';
import '../logger/log.dart';
import '../toast/toast.dart';

class FormOpeningController {
  static final _logger = LoggerService.getLogger('FormOpeningController');
  static final FormsOpeningAPIHandler _formsOpeningAPIHandler =
      FormsOpeningAPIHandler();

  static Future<void> init() async {
    _logger.info('Initializing FormOpeningController');
  }

  static Future<SmartShedOpenedForm?> createForm(
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
      return SmartShedOpenedForm.fromJson(response['form']);
    } else {
      ToastController.error(response['message']);
      return null;
    }
  }

  static Future<SmartShedForm?> getForm(String formId) async {
    _logger.info('Fetching form with formId: $formId');
    final response = await _formsOpeningAPIHandler.getForm(formId);

    if (response['status'] == 'success') {
      return SmartShedForm.fromJson(response['form']);
    } else {
      ToastController.error(response['message']);
      return null;
    }
  }
}
