import 'package:dio/dio.dart';
import 'package:smartshed/controllers/env/controller.dart';
import 'package:smartshed/utils/api/google_sheets.dart';

import '../../constants/api.dart';
import '../../controllers/logger/log.dart';

class BackendUrlAPIHandler {
  static final _logger = LoggerService.getLogger('BackendUrlAPIHandler');

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
}
