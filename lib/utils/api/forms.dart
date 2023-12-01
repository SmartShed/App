import 'package:dio/dio.dart';

import '../../constants/api.dart';
import '../cache/xauth_token.dart';
import '../../controllers/logger/log.dart';

class FormsAPIHandler {
  static final _logger = LoggerService.getLogger('FormsAPIHandler');

  FormsAPIHandler._internal();
  static final FormsAPIHandler _formsAPIHandler = FormsAPIHandler._internal();
  factory FormsAPIHandler() => _formsAPIHandler;

  final Dio _dio = Dio();

  final String _authToken = XAuthTokenHandler.token!;

  Future<Map<String, dynamic>> getRecentForms() async {
    try {
      _logger.info('Calling getRecentForms API');
      final response = await _dio.get(
        APIConstants.recentlyOpenedForms,
        options: Options(
          headers: {
            'auth_token': _authToken,
          },
        ),
      );

      _logger.info('getRecentForms API called successfully');
      return {
        'status': 'success',
        'message': response.data['message'],
        'forms': response.data['forms'],
      };
    } on DioException catch (e) {
      _logger.error(
          'Error calling getRecentForms API: ${e.response!.data['message']}');
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }
}
