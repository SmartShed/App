import '../../models/opened_form.dart';
import '../../utils/api/forms_access.dart';
import '../logger/log.dart';
import '../toast/toast.dart';

class DashboardForMeController {
  static final _logger = LoggerService.getLogger('DashboardForMeController');
  static final FormsAccessAPIHandler _formsAPIHandler = FormsAccessAPIHandler();

  static Future<void> init() async {
    _logger.info('Initializing DashboardForMeController');
  }

  static Future<List<SmartShedOpenedForm>> getRecentlyOpenedForms() async {
    _logger.info('Getting recently opened forms');

    final response = await _formsAPIHandler.getRecentForms();

    List<SmartShedOpenedForm> forms = [];

    if (response['status'] == 'success') {
      if (response['forms'].length == 0) {
        ToastController.warning('No recently opened forms found');
        return forms;
      }

      for (var form in response['forms']) {
        forms.add(SmartShedOpenedForm.fromJson(form));
      }
    } else {
      ToastController.error(response['message']);
    }

    return forms;
  }

  static Future<List<SmartShedOpenedForm>> getRecentlyOpenedFormsForSection(
      String sectionIdOrName) async {
    _logger.info('Getting recently opened forms for section $sectionIdOrName');

    final response =
        await _formsAPIHandler.getRecentFormsForSection(sectionIdOrName);

    List<SmartShedOpenedForm> forms = [];

    if (response['status'] == 'success') {
      if (response['forms'].length == 0) {
        ToastController.warning('No recently opened forms found');
        return forms;
      }

      for (var form in response['forms']) {
        forms.add(SmartShedOpenedForm.fromJson(form));
      }
    } else {
      ToastController.error(response['message']);
    }

    return forms;
  }
}
