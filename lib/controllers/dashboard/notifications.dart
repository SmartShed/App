import '../../models/notification.dart';
import '../../utils/api/notifications.dart';
import '../logger/log.dart';

class NotificationsController {
  final _logger = LoggerService.getLogger('NotificationsController');

  final NotificationApiHandler _notificationApiHandler =
      NotificationApiHandler();

  NotificationsController._internal();

  static final NotificationsController _notificationsController =
      NotificationsController._internal();

  factory NotificationsController() => _notificationsController;

  final List<SmartShedNotification> _notifications = [];

  List<SmartShedNotification> get notifications => _notifications;

  List<SmartShedNotification> get unreadNotifications => _notifications
      .where((notification) => notification.isRead == false)
      .toList();

  List<SmartShedNotification> get readNotifications => _notifications
      .where((notification) => notification.isRead == true)
      .toList();

  int get unreadNotificationsCount => _notifications
      .where((notification) => notification.isRead == false)
      .toList()
      .length;

  Future<void> fetchNotifications({void Function()? onDone}) async {
    _logger.info('Fetching notifications');
    final response = await _notificationApiHandler.getNotifications();

    if (response['status'] == 'success') {
      _notifications.clear();
      response['notifications'].forEach((notification) {
        _notifications.add(SmartShedNotification.fromJson(notification));
      });
      _logger.info('Notifications fetched successfully');
    } else {
      _logger.error('Error while fetching notifications');
    }

    onDone?.call();
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    _logger.info('Marking notification as read: $notificationId');

    notifications
        .firstWhere((notification) => notification.id == notificationId)
        .isRead = true;

    final response =
        await _notificationApiHandler.markNotificationAsRead(notificationId);

    if (response['status'] == 'success') {
      _logger.info('Notification marked as read: $notificationId');
    } else {
      _logger
          .error('Error while marking notification as read: $notificationId');
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    _logger.info('Deleting notification: $notificationId');

    notifications
        .removeWhere((notification) => notification.id == notificationId);

    final response =
        await _notificationApiHandler.deleteNotification(notificationId);

    if (response['status'] == 'success') {
      _logger.info('Notification deleted: $notificationId');
    } else {
      _logger.error('Error while deleting notification: $notificationId');
    }
  }

  Future<void> deleteAllNotifications() async {
    _logger.info('Deleting all notifications');

    notifications.clear();

    final response = await _notificationApiHandler.deleteAllNotifications();

    if (response['status'] == 'success') {
      _logger.info('All notifications deleted');
    } else {
      _logger.error('Error while deleting all notifications');
    }
  }
}
