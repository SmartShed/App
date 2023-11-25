import 'package:dio/dio.dart';

import '../../constants/api.dart';
import '../cache/xauth_token.dart';

class SectionsAPIHandler {
  SectionsAPIHandler._internal();
  static final SectionsAPIHandler _sectionsAPIHandler =
      SectionsAPIHandler._internal();
  factory SectionsAPIHandler() => _sectionsAPIHandler;

  final Dio _dio = Dio();

  final String _authToken = XAuthTokenHandler.token!;

  Future<Map<String, dynamic>> getAllSections() async {
    try {
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
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> getFormsBySectionId(String sectionId) async {
    try {
      final response = await _dio.get(
        '${APIConstants.sections}/$sectionId/forms',
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
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }
}
