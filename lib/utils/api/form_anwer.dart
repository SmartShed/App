import 'package:dio/dio.dart';

import '../../constants/api.dart';
import '../../controllers/logger/log.dart';
import '../cache/xauth_token.dart';

class FormsAnswerAPIHandler {
  static final _logger = LoggerService.getLogger('FormsAnswerAPIHandler');

  FormsAnswerAPIHandler._internal();
  static final FormsAnswerAPIHandler _formsAPIHandler =
      FormsAnswerAPIHandler._internal();
  factory FormsAnswerAPIHandler() => _formsAPIHandler;

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> saveForm(String formId, List answers) async {
    try {
      _logger.info('Calling saveForm API');
      final response = await _dio.post(
        APIConstants.saveForm.replaceFirst(':id', formId),
        data: {
          'answers': answers,
        },
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token,
          },
        ),
      );

      _logger.info('saveForm API called successfully');
      return {
        'status': 'success',
        'message': response.data['message'],
      };
    } on DioException catch (e) {
      _logger
          .error('Error calling saveForm API: ${e.response!.data['message']}');
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> submitForm(String formId, List answers) async {
    try {
      _logger.info('Calling submitForm API');
      final response = await _dio.post(
        APIConstants.submitForm.replaceFirst(':id', formId),
        data: {
          'answers': answers,
        },
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token,
          },
        ),
      );

      _logger.info('submitForm API called successfully');
      return {
        'status': 'success',
        'message': response.data['message'],
      };
    } on DioException catch (e) {
      _logger.error(
          'Error calling submitForm API: ${e.response!.data['message']}');
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }
}
