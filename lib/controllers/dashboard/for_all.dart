import '../../models/section.dart';
import '../../models/form.dart';
import '../../utils/api/sections.dart';
import '../toast/toast.dart';
import '../logger/log.dart';

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

  static Future<List<SmartShedForm>> getFormsForSection(
      String sectionIdOrName) async {
    _logger.info('Fetching forms for section: $sectionIdOrName');
    final response =
        await _sectionsAPIHandler.getFormsBySectionIdOrName(sectionIdOrName);

    List<SmartShedForm> forms = [];

    if (response['status'] == 'success') {
      if (response['forms'].length == 0) {
        ToastController.error('No forms found for this section');
        return forms;
      }

      for (var form in response['forms']) {
        forms.add(SmartShedForm.fromJson(form));
      }
    } else {
      ToastController.error(response['message']);
    }

    return forms;
  }
}
