import 'package:dio/dio.dart';

import '../../constants/api.dart';
import '../cache/xauth_token.dart';
import '../../controllers/logger/log.dart';

class FormsOpeningAPIHandler {
  static final _logger = LoggerService.getLogger('FormsOpeningAPIHandler');

  FormsOpeningAPIHandler._internal();
  static final FormsOpeningAPIHandler _formsOpeningAPIHandler =
      FormsOpeningAPIHandler._internal();
  factory FormsOpeningAPIHandler() => _formsOpeningAPIHandler;

  final Dio _dio = Dio();

  final String _authToken = XAuthTokenHandler.token!;

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
            'auth_token': _authToken,
          },
        ),
      );

      _logger.info('createForm API called successfully');

      return {
        'status': 'success',
        'message': response.data['message'],
        'newFormID': response.data['newFormID'],
      };
    } on DioException catch (e) {
      _logger.error(
          'Error calling createForm API: ${e.response!.data['message']}');
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }
}
