import '../../models/full_form.dart';
import '../../models/full_unopened_form.dart';
import '../../models/opened_form.dart';
import '../../utils/api/forms_open.dart';
import '../logger/log.dart';

class FormOpeningController {
  static final _logger = LoggerService.getLogger('FormOpeningController');
  static final FormsOpeningAPIHandler _formsOpeningAPIHandler =
      FormsOpeningAPIHandler();

  static Future<SmartShedOpenedForm?> createForm(
      String formId, String locoName, String locoNumber) async {
    _logger.info(
        'Creating form with formId: $formId, locoName: $locoName, locoNumber: $locoNumber');

    final response =
        await _formsOpeningAPIHandler.createForm(formId, locoName, locoNumber);

    if (response['status'] == 'success') {
      return SmartShedOpenedForm.fromJson(response['form']);
    }
    return null;
  }

  static Future<SmartShedForm?> getForm(String formId) async {
    _logger.info('Fetching form with formId: $formId');
    final response = await _formsOpeningAPIHandler.getForm(formId);

    if (response['status'] == 'success') {
      return SmartShedForm.fromJson(response['form']);
    }
    return null;
  }

  static Future<SmartShedFullUnopenedForm?> getUnopenedForm(
      String formId) async {
    _logger.info('Fetching unopened form with formId: $formId');
    final response = await _formsOpeningAPIHandler.getUnopenedForm(formId);

    if (response['status'] == 'success') {
      return SmartShedFullUnopenedForm.fromJson(response['form']);
    }
    return null;
  }
}
