import '../../models/opened_form.dart';
import '../../models/section.dart';
import '../../models/unopened_form.dart';
import '../../utils/api/sections.dart';
import '../logger/log.dart';
import '../toast/toast.dart';

class DashboardForAllController {
  static final SectionsAPIHandler _sectionsAPIHandler = SectionsAPIHandler();
  static final _logger = LoggerService.getLogger('DashboardForAllController');

  static Future<void> init() async {
    _logger.info('Initializing DashboardForAllController');
  }

  static Future<List<SmartShedSection>> getSections() async {
    _logger.info('Fetching sections');
    final response = await _sectionsAPIHandler.getAllSections();

    List<SmartShedSection> sections = [];

    if (response['status'] == 'success') {
      if (response['sections'].length == 0) {
        ToastController.error('No sections found');
        return sections;
      }

      for (var section in response['sections']) {
        sections.add(SmartShedSection.fromJson(section));
      }
    } else {
      ToastController.error(response['message']);
    }

    return sections;
  }

  static Future<List<SmartShedUnopenedForm>> getFormsForSection(
      String sectionIdOrName) async {
    _logger.info('Fetching forms for section: $sectionIdOrName');
    final response =
        await _sectionsAPIHandler.getFormsBySectionIdOrName(sectionIdOrName);

    List<SmartShedUnopenedForm> forms = [];

    if (response['status'] == 'success') {
      if (response['forms'].length == 0) {
        ToastController.error('No forms found for this section');
        return forms;
      }

      for (var form in response['forms']) {
        forms.add(SmartShedUnopenedForm.fromJson(form));
      }
    } else {
      ToastController.error(response['message']);
    }

    return forms;
  }

  static Future<List<SmartShedOpenedForm>> getOpenedFormsForSection(
      String sectionIdOrName) async {
    _logger.info('Fetching opened forms for section: $sectionIdOrName');
    final response = await _sectionsAPIHandler
        .getOpenedFormsBySectionIdOrName(sectionIdOrName);

    List<SmartShedOpenedForm> forms = [];

    if (response['status'] == 'success') {
      if (response['forms'].length == 0) {
        ToastController.error('No opened forms found for this section');
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
