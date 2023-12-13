import 'package:dio/dio.dart';

import '../../constants/api.dart';
import '../../controllers/logger/log.dart';
import '../cache/xauth_token.dart';

class FormsAccessAPIHandler {
  static final _logger = LoggerService.getLogger('FormsAccessAPIHandler');

  FormsAccessAPIHandler._internal();
  static final FormsAccessAPIHandler _formsAPIHandler =
      FormsAccessAPIHandler._internal();
  factory FormsAccessAPIHandler() => _formsAPIHandler;

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getRecentForms() async {
    try {
      _logger.info('Calling getRecentForms API');
      final response = await _dio.get(
        APIConstants.recentlyOpenedForms,
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token,
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

  Future<Map<String, dynamic>> getRecentFormsForSection(
      String sectionIdOrName) async {
    try {
      _logger.info('Calling getRecentFormsForSection API');
      final response = await _dio.get(
        APIConstants.recentlyOpenedFormsForSection
            .replaceFirst(':idOrName', sectionIdOrName),
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token,
          },
        ),
      );

      _logger.info('getRecentFormsForSection API called successfully');
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
