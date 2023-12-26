import 'package:dio/dio.dart';

import '../../constants/api.dart';
import '../../controllers/auth/login.dart';
import '../../controllers/logger/log.dart';
import '../cache/xauth_token.dart';

class FormsApproveApiHandler {
  static final _logger = LoggerService.getLogger('FormsApproveApiHandler');

  FormsApproveApiHandler._internal();
  static final FormsApproveApiHandler _formsApproveApiHandler =
      FormsApproveApiHandler._internal();
  factory FormsApproveApiHandler() => _formsApproveApiHandler;

  final Dio _dio = Dio();

  String _getUnapprovedFormsApi() => LoginController.isSupervisor
      ? APIConstants.getUnapprovedFormsForSupervisor
      : APIConstants.getUnapprovedFormsForAuthority;

  String _getApprovedFormsApi() => LoginController.isSupervisor
      ? APIConstants.getApprovedFormsForSupervisor
      : APIConstants.getApprovedFormsForAuthority;

  String _approveFormApi() => LoginController.isSupervisor
      ? APIConstants.approveFormForSupervisor
      : APIConstants.approveFormForAuthority;

  String _rejectFormApi() => LoginController.isSupervisor
      ? APIConstants.rejectFormForSupervisor
      : APIConstants.rejectFormForAuthority;

  Future<Map<String, dynamic>> getUnapprovedForms() async {
    try {
      _logger.info('Calling getUnapprovedForms API');
      final response = await _dio.get(
        _getUnapprovedFormsApi(),
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token,
          },
        ),
      );

      _logger.info('getUnapprovedForms API called successfully');
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

  Future<Map<String, dynamic>> getApprovedForms() async {
    try {
      _logger.info('Calling getApprovedForms API');
      final response = await _dio.get(
        _getApprovedFormsApi(),
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token,
          },
        ),
      );

      _logger.info('getApprovedForms API called successfully');
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

  Future<Map<String, dynamic>> approveForm(String formId) async {
    try {
      _logger.info('Calling approveForm API');
      final response = await _dio.post(
        _approveFormApi(),
        data: {
          'formID': formId,
        },
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token,
          },
        ),
      );

      _logger.info('approveForm API called successfully');
      return {
        'status': 'success',
        'message': response.data['message'],
      };
    } on DioException catch (e) {
      _logger.error(e);
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> rejectForm(String formId) async {
    try {
      _logger.info('Calling rejectForm API');
      final response = await _dio.post(
        _rejectFormApi(),
        data: {
          'formID': formId,
        },
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token,
          },
        ),
      );

      _logger.info('rejectForm API called successfully');
      return {
        'status': 'success',
        'message': response.data['message'],
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
