import 'package:dio/dio.dart';

import '../../constants/api.dart';
import '../../controllers/logger/log.dart';
import '../cache/xauth_token.dart';

class NotificationApiHandler {
  static final _logger = LoggerService.getLogger('NotificationApiHandler');

  NotificationApiHandler._internal();
  static final NotificationApiHandler _notificationApiHandler =
      NotificationApiHandler._internal();
  factory NotificationApiHandler() => _notificationApiHandler;

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getNotifications() async {
    try {
      _logger.info('Calling getNotifications API');
      final response = await _dio.get(
        APIConstants.getNotifications,
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token!,
          },
        ),
      );

      _logger.info('getNotifications API called successfully');

      return {
        'status': 'success',
        'message': response.data['message'],
        'notifications': response.data['notifications'],
      };
    } on DioException catch (e) {
      _logger.error(e);
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> markNotificationAsRead(
      String notificationId) async {
    try {
      _logger.info('Calling markNotificationAsRead API');
      final response = await _dio.put(
        APIConstants.markNotificationAsRead.replaceFirst(':id', notificationId),
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token!,
          },
        ),
      );

      _logger.info('markNotificationAsRead API called successfully');

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

  Future<Map<String, dynamic>> deleteNotification(String notificationId) async {
    try {
      _logger.info('Calling deleteNotification API');
      final response = await _dio.delete(
        APIConstants.deleteNotification.replaceFirst(':id', notificationId),
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token!,
          },
        ),
      );

      _logger.info('deleteNotification API called successfully');

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

  Future<Map<String, dynamic>> deleteAllNotifications() async {
    try {
      _logger.info('Calling deleteAllNotifications API');
      final response = await _dio.delete(
        APIConstants.deleteAllNotifications,
        options: Options(
          headers: {
            'auth_token': XAuthTokenCacheHandler.token!,
          },
        ),
      );

      _logger.info('deleteAllNotifications API called successfully');

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
