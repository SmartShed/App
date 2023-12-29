import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';

import '../../controllers/env/controller.dart';
import '../../controllers/logger/log.dart';

class GoogleSheetApiHandler {
  static final _logger = LoggerService.getLogger('GoogleSheetApiHandler');

  static final List<String> _scopes = [
    SheetsApi.spreadsheetsScope,
    SheetsApi.spreadsheetsReadonlyScope,
  ];

  static Future<AutoRefreshingAuthClient> _getAuthToken() async {
    final credentials = ServiceAccountCredentials.fromJson({
      'type': 'service_account',
      'client_id': EnvController.getEnv('GOOGLE_CLIENT_ID'),
      'client_email': EnvController.getEnv('GOOGLE_CLIENT_EMAIL'),
      'private_key':
          EnvController.getEnv('GOOGLE_PRIVATE_KEY').replaceAll('\\n', '\n'),
    });

    return await clientViaServiceAccount(credentials, _scopes);
  }

  static Future<List<List<dynamic>>> _getValues(
      String spreadsheetId, String range) async {
    try {
      final client = await _getAuthToken();
      final sheetsApi = SheetsApi(client);
      final response = await sheetsApi.spreadsheets.values.get(
        spreadsheetId,
        range,
        majorDimension: 'COLUMNS',
      );

      return response.values!;
    } catch (e) {
      _logger.error(e);
      return [];
    }
  }

  static Future<List<List<dynamic>>> getEmployees() async {
    return await _getValues(
      EnvController.getEnv('EMPLOYEE_SHEET_ID'),
      'A1:C',
    );
  }

  static Future<List<List<dynamic>>> getUrls() async {
    return await _getValues(
      EnvController.getEnv('URLS_SHEET_ID'),
      'A1:B',
    );
  }
}
