import '../../models/opened_form.dart';
import '../../models/section.dart';
import '../../models/unopened_form.dart';
import '../../utils/api/sections.dart';
import '../logger/log.dart';

class DashboardForAllController {
  static final SectionsAPIHandler _sectionsAPIHandler = SectionsAPIHandler();
  static final _logger = LoggerService.getLogger('DashboardForAllController');

  static Future<void> init() async {
    _logger.info('Initializing DashboardForAllController');
  }

  static Future<List<SmartShedSection>?> getSections() async {
    _logger.info('Fetching sections');
    final response = await _sectionsAPIHandler.getAllSections();

    List<SmartShedSection> sections = [];

    if (response['status'] == 'success') {
      for (var section in response['sections']) {
        sections.add(SmartShedSection.fromJson(section));
      }
      return sections;
    }
    return null;
  }

  static Future<List<SmartShedUnopenedForm>?> getFormsForSection(
      String sectionIdOrName) async {
    _logger.info('Fetching forms for section: $sectionIdOrName');
    final response =
        await _sectionsAPIHandler.getFormsBySectionIdOrName(sectionIdOrName);

    List<SmartShedUnopenedForm> forms = [];

    if (response['status'] == 'success') {
      for (var form in response['forms']) {
        forms.add(SmartShedUnopenedForm.fromJson(form));
      }
      return forms;
    }

    return null;
  }

  static Future<List<SmartShedOpenedForm>?> getOpenedFormsForSection(
      String sectionIdOrName) async {
    _logger.info('Fetching opened forms for section: $sectionIdOrName');
    final response = await _sectionsAPIHandler
        .getOpenedFormsBySectionIdOrName(sectionIdOrName);

    List<SmartShedOpenedForm> forms = [];

    if (response['status'] == 'success') {
      for (var form in response['forms']) {
        forms.add(SmartShedOpenedForm.fromJson(form));
      }
      return forms;
    }

    return null;
  }
}
