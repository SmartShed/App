import 'package:dio/dio.dart';

import '../../constants/api.dart';
import '../../controllers/logger/log.dart';
import '../cache/xauth_token.dart';

class FormsOpeningAPIHandler {
  static final _logger = LoggerService.getLogger('FormsOpeningAPIHandler');

  FormsOpeningAPIHandler._internal();
  static final FormsOpeningAPIHandler _formsOpeningAPIHandler =
      FormsOpeningAPIHandler._internal();
  factory FormsOpeningAPIHandler() => _formsOpeningAPIHandler;

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> createForm(
    String formId,
    String locoName,
    String locoNumber,
  ) async {
    try {
      _logger.info('Calling createForm API');
      final response = await _dio.post(
        APIConstants.createForm,
        data: {
          'form_id': formId,
          'loco_name': locoName,
          'loco_number': locoNumber,
        },
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token!,
          },
        ),
      );

      _logger.info('createForm API called successfully');

      return {
        'status': 'success',
        'message': response.data['message'],
        'form': response.data['form'],
      };
    } on DioException catch (e) {
      _logger.error(e);
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> getForm(String formId) async {
    try {
      _logger.info('Calling getForm API for form $formId');
      final response = await _dio.get(
        APIConstants.getForm.replaceFirst(':id', formId),
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token!,
          },
        ),
      );

      _logger.info('getForm API called successfully');

      return {
        'status': 'success',
        'message': response.data['message'],
        'form': response.data['form'],
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
