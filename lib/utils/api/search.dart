import 'package:dio/dio.dart';

import '../../constants/api.dart';
import '../../controllers/logger/log.dart';
import '../cache/xauth_token.dart';

class SearchApiHandler {
  static final _logger = LoggerService.getLogger('SearchApiHandler');

  SearchApiHandler._internal();
  static final SearchApiHandler _searchApiHandler =
      SearchApiHandler._internal();
  factory SearchApiHandler() => _searchApiHandler;

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> search(
    String? formTitle,
    String? locoType,
    String? locoNumber,
  ) async {
    try {
      _logger.info('Calling search API');
      final response = await _dio.get(
        APIConstants.searchForms,
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token,
          },
        ),
        queryParameters: {
          if (formTitle != null) 'title': formTitle,
          if (locoType != null) 'type': locoType,
          if (locoNumber != null) 'number': locoNumber,
        },
      );

      _logger.info('search API called successfully');
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
