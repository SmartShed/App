import 'dart:math';

// Dummy data
import '../../dummy/data.dart';
import '../../models/opened_form.dart';
import '../../utils/api/forms.dart';
import '../toast/toast.dart';
import '../logger/log.dart';

class DashboardForMeController {
  static final FormsAPIHandler _formsAPIHandler = FormsAPIHandler();
  static final _logger = LoggerService.getLogger('DashboardForMeController');

  static Future<void> init() async {
    _logger.info('Initializing DashboardForMeController');
  }

  static Future<List<OpenedSmartShedForm>> getRecentlyOpenedForms() async {
    _logger.info('Getting recently opened forms');

    final response = await _formsAPIHandler.getRecentForms();

    List<OpenedSmartShedForm> forms = [];

    if (response['status'] == 'success') {
      if (response['forms'].length == 0) {
        ToastController.warning('No recently opened forms found');
        return forms;
      }

      for (var form in response['forms']) {
        forms.add(OpenedSmartShedForm.fromJson(form));
      }
    } else {
      ToastController.error(response['message']);
    }

    return forms;
  }

  static Future<List<OpenedSmartShedForm>> getRecentlyOpenedFormsByMeForSection(
      String sectionId) async {
    _logger.info('Getting recently opened forms by me for section $sectionId');

    // return await Future.delayed(Duration(milliseconds: Random().nextInt(2000)),
    //     () {
    //   return DummyData.getRecentlyOpenedFormsByMeForSection(sectionId);
    // });
    return [];
  }

  static Future<List<OpenedSmartShedForm>> getRecentlyOpenedFormsForSection(
      String sectionId) async {
    _logger.info('Getting recently opened forms for section $sectionId');

    // return await Future.delayed(Duration(milliseconds: Random().nextInt(2000)),
    //     () {
    //   return DummyData.getRecentlyOpenedFormsForSection(sectionId);
    // });
    return [];
  }
}
