import '../../models/opened_form.dart';
import '../../utils/api/forms_approve.dart';
import '../logger/log.dart';
import '../toast/toast.dart';

class FormApprovingController {
  static final _logger = LoggerService.getLogger('FormApprovingController');

  static final FormsApproveApiHandler _formsApproveApiHandler =
      FormsApproveApiHandler();

  static Future<List<SmartShedOpenedForm>> getUnapprovedForms() async {
    _logger.info('Getting unapproved forms');

    final response = await _formsApproveApiHandler.getUnapprovedForms();

    List<SmartShedOpenedForm> forms = [];

    if (response['status'] == 'success') {
      if (response['forms'].length == 0) {
        return forms;
      }

      for (var form in response['forms']) {
        forms.add(SmartShedOpenedForm.fromJson(form));
      }
    }

    return forms;
  }

  static Future<List<SmartShedOpenedForm>> getApprovedForms() async {
    _logger.info('Getting approved forms');

    final response = await _formsApproveApiHandler.getApprovedForms();

    List<SmartShedOpenedForm> forms = [];

    if (response['status'] == 'success') {
      if (response['forms'].length == 0) {
        return forms;
      }

      for (var form in response['forms']) {
        forms.add(SmartShedOpenedForm.fromJson(form));
      }
    }

    return forms;
  }

  static Future<bool> approveForm(String formId) async {
    _logger.info('Approving form: $formId');

    final response = await _formsApproveApiHandler.approveForm(formId);

    if (response['status'] == 'success') {
      ToastController.success(response['message']);
      return true;
    }

    ToastController.error(response['message']);
    return false;
  }

  static Future<bool> rejectForm(String formId) async {
    _logger.info('Rejecting form: $formId');

    final response = await _formsApproveApiHandler.rejectForm(formId);

    if (response['status'] == 'success') {
      ToastController.success(response['message']);
      return true;
    }

    ToastController.error(response['message']);
    return false;
  }
}
