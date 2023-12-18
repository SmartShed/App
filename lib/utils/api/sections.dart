import 'package:dio/dio.dart';

import '../../constants/api.dart';
import '../../controllers/logger/log.dart';
import '../cache/xauth_token.dart';

class SectionsAPIHandler {
  static final _logger = LoggerService.getLogger('SectionsAPIHandler');

  SectionsAPIHandler._internal();
  static final SectionsAPIHandler _sectionsAPIHandler =
      SectionsAPIHandler._internal();
  factory SectionsAPIHandler() => _sectionsAPIHandler;

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getAllSections() async {
    try {
      _logger.info('Calling getAllSections API');
      final response = await _dio.get(
        APIConstants.sections,
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token!,
          },
        ),
      );

      return {
        'status': 'success',
        'message': response.data['message'],
        'sections': response.data['sections'],
      };
    } on DioException catch (e) {
      _logger.error(e);
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> getFormsBySectionIdOrName(
      String sectionIdOrName) async {
    try {
      _logger
          .info('Calling getFormsBySection API with section: $sectionIdOrName');
      final response = await _dio.get(
        APIConstants.formsBySectionIdOrName
            .replaceFirst(':idOrName', sectionIdOrName),
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token!,
          },
        ),
      );

      return {
        'status': 'success',
        'message': response.data['message'],
        'forms': response.data['forms'],
      };
    } on DioException catch (e) {
      _logger.error(e);
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> getOpenedFormsBySectionIdOrName(
      String sectionIdOrName) async {
    try {
      _logger.info(
          'Calling getOpenedFormsBySection API with section: $sectionIdOrName');
      final response = await _dio.get(
        APIConstants.openedFormsBySectionIdOrName
            .replaceFirst(':idOrName', sectionIdOrName),
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token!,
          },
        ),
      );

      return {
        'status': 'success',
        'message': response.data['message'],
        'forms': response.data['forms'],
      };
    } on DioException catch (e) {
      _logger.error(e);
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }
}
