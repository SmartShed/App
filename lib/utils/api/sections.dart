import 'package:dio/dio.dart';

import '../../constants/api.dart';
import '../cache/xauth_token.dart';
import '../../controllers/logger/log.dart';

class SectionsAPIHandler {
  static final _logger = LoggerService.getLogger('SectionsAPIHandler');

  SectionsAPIHandler._internal();
  static final SectionsAPIHandler _sectionsAPIHandler =
      SectionsAPIHandler._internal();
  factory SectionsAPIHandler() => _sectionsAPIHandler;

  final Dio _dio = Dio();

  final String _authToken = XAuthTokenHandler.token!;

  Future<Map<String, dynamic>> getAllSections() async {
    try {
      _logger.info('Calling getAllSections API');
      final response = await _dio.get(
        APIConstants.sections,
        options: Options(
          headers: {
            'auth_token': _authToken,
          },
        ),
      );

      return {
        'status': 'success',
        'message': response.data['message'],
        'sections': response.data['sections'],
      };
    } on DioException catch (e) {
      _logger.error(
          'Error calling getAllSections API: ${e.response!.data['message']}');
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> getFormsBySectionIdOrName(
      String sectionIdOrName) async {
    try {
      _logger.info(
          'Calling getFormsBySectionId API with sectionId: $sectionIdOrName');
      final response = await _dio.get(
        '${APIConstants.sections}/$sectionIdOrName/forms',
        options: Options(
          headers: {
            'auth_token': _authToken,
          },
        ),
      );

      return {
        'status': 'success',
        'message': response.data['message'],
        'forms': response.data['forms'],
      };
    } on DioException catch (e) {
      _logger.error(
          'Error calling getFormsBySectionId API with sectionId: $sectionIdOrName: ${e.response!.data['message']}');
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }
}
