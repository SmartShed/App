import '../../constants/api.dart';
import '../env/env.dart';
import '../../controllers/logger/log.dart';
import '../../utils/api/google_sheets.dart';

class UrlController {
  static final _logger = LoggerService.getLogger('UrlController');

  static Future<List<String>> _getUrls() async {
    _logger.info('Getting backend url');

    final response = await GoogleSheetApiHandler.getUrls();

    _logger.info('Backend url retrieved successfully');

    String backendUrl = response[0][1];
    backendUrl = backendUrl.trim();

    String userManualUrl = response[1][1];
    userManualUrl = userManualUrl.trim();

    if (backendUrl.endsWith('/')) {
      backendUrl = backendUrl.substring(0, backendUrl.length - 1);
    }

    if (userManualUrl.endsWith('/')) {
      userManualUrl = userManualUrl.substring(0, userManualUrl.length - 1);
    }

    return [backendUrl, userManualUrl];
  }

  static Future<void> setUrls() async {
    try {
      final List<String> urls = await _getUrls();
      final String backendUrl = urls[0];

      _logger.info('Setting backend url to $backendUrl');
      APIConstants.setBaseUrl(backendUrl);

      final String userManualUrl = urls[1];
      _logger.info('Setting user manual url to $userManualUrl');
      APIConstants.setUserManualUrl(userManualUrl);
    } catch (e) {
      _logger.error('Error while setting backend url');
      _logger.info('Setting default backend url to ${Env.defaultBackendUrl}');
      APIConstants.setBaseUrl(Env.defaultBackendUrl);

      _logger.error('Error while setting user manual url');
    }
  }

  static Future<void> setBackendUrlToDefault() async {
    _logger.info('Setting backend url to default to ${Env.defaultBackendUrl}');
    APIConstants.setBaseUrl(Env.defaultBackendUrl);
  }
}
