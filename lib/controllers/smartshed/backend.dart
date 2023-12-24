import '../../constants/api.dart';
import '../../controllers/env/controller.dart';
import '../../controllers/logger/log.dart';
import '../../utils/api/google_sheets.dart';

class BackendController {
  static final _logger = LoggerService.getLogger('BackendController');

  static Future<String> _getBackendUrl() async {
    _logger.info('Getting backend url');

    final response = await GoogleSheetApiHandler.getBackendUrl();

    _logger.info('Backend url retrieved successfully');

    String backendUrl = response[0][0];

    backendUrl = backendUrl.trim();

    if (backendUrl.endsWith('/')) {
      backendUrl = backendUrl.substring(0, backendUrl.length - 1);
    }

    return backendUrl;
  }

  static Future<void> setBackendUrl() async {
    try {
      final String backendUrl = await _getBackendUrl();
      _logger.info('Setting backend url to $backendUrl');
      APIConstants.setBaseUrl(backendUrl);
    } catch (e) {
      _logger.error('Error while setting backend url');
      _logger.info(
          'Setting default backend url to ${EnvController.getDefaultBackendUrl()}');
      APIConstants.setBaseUrl(EnvController.getDefaultBackendUrl());
    }
  }

  static Future<void> setBackendUrlToDefault() async {
    _logger.info(
        'Setting backend url to default to ${EnvController.getDefaultBackendUrl()}');
    APIConstants.setBaseUrl(EnvController.getDefaultBackendUrl());
  }
}
