import '../../models/opened_form.dart';
import '../../utils/api/search.dart';
import '../logger/log.dart';

class FormsSearchController {
  static final _logger = LoggerService.getLogger('FormsSearchController');

  static final SearchApiHandler _searchApiHandler = SearchApiHandler();

  static Future<List<SmartShedOpenedForm>?> search(
    String formTitle,
    String locoType,
    String locoNumber,
  ) async {
    _logger.info('Searching for forms');

    final response = await _searchApiHandler.search(
      formTitle.isEmpty ? null : formTitle.trim(),
      locoType.isEmpty ? null : locoType.trim(),
      locoNumber.isEmpty ? null : locoNumber.trim(),
    );

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
