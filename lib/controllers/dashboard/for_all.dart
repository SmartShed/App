import '../../models/section.dart';
import '../../models/form.dart';

import '../../utils/api/sections.dart';
import '../toast/toast.dart';

class DashboardForAllController {
  static final SectionsAPIHandler _sectionsAPIHandler = SectionsAPIHandler();

  static Future<void> init() async {}

  static Future<List<SmartShedSection>> getSections() async {
    final response = await _sectionsAPIHandler.getAllSections();

    List<SmartShedSection> sections = [];

    if (response['status'] == 'success') {
      for (var section in response['sections']) {
        sections.add(SmartShedSection.fromJson(section));
      }
    } else {
      ToastController.error(response['message']);
    }

    return sections;
  }

  static Future<List<SmartShedForm>> getFormsForSection(
      String sectionId) async {
    final response = await _sectionsAPIHandler.getFormsBySectionId(sectionId);

    List<SmartShedForm> forms = [];

    if (response['status'] == 'success') {
      for (var form in response['forms']) {
        forms.add(SmartShedForm.fromJson(form));
      }
    } else {
      ToastController.error(response['message']);
    }

    return forms;
  }
}
