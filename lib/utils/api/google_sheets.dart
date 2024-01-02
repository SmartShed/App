import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';

import '../../controllers/env/env.dart';
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
      'client_id': Env.googleClientId,
      'client_email': Env.googleClientEmail,
      'private_key': Env.googlePrivateKey.replaceAll('\\n', '\n'),
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
      Env.employeeSheetId,
      'A1:C',
    );
  }

  static Future<List<List<dynamic>>> getUrls() async {
    return await _getValues(
      Env.urlsSheetId,
      'A1:B',
    );
  }
}
