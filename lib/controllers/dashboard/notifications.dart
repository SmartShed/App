import 'package:smartshed/controllers/logger/log.dart';
import 'package:smartshed/models/notification.dart';

class NotificationsController {
  final _logger = LoggerService.getLogger('NotificationsController');

  NotificationsController._internal();

  static final NotificationsController _notificationsController =
      NotificationsController._internal();

  factory NotificationsController() => _notificationsController;

  final List<SmartShedNotification> _notifications = [];

  List<SmartShedNotification> get notifications => _notifications;

  int get unreadNotificationsCount => _notifications
      .where((notification) => notification.isRead == false)
      .toList()
      .length;

  Future<void> fetchNotifications({void Function()? onDone}) async {
    _logger.info('Fetching notifications');
    _notifications.clear();
    await Future.delayed(const Duration(seconds: 1), () {
      _notifications.add(SmartShedNotification(
        id: '1',
        contentEnglish: 'This is a test notification 1',
        contentHindi: 'यह एक परीक्षण सूचना है 1',
        isRead: false,
        createdAt: DateTime.now(),
        formId: '1',
      ));
      _notifications.add(SmartShedNotification(
        id: '2',
        contentEnglish: 'This is a test notification 2',
        contentHindi: 'यह एक परीक्षण सूचना है 2',
        isRead: false,
        createdAt: DateTime.now(),
        formId: '1',
      ));
    });

    _logger.info('Notifications fetched');
    onDone?.call();
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    _logger.info('Marking notification as read: $notificationId');
    final notification = _notifications
        .firstWhere((notification) => notification.id == notificationId);

    notification.isRead = true;

    _logger.info('Notification marked as read: $notificationId');
  }

  Future<void> deleteNotification(String notificationId) async {
    _logger.info('Deleting notification: $notificationId');
    _notifications
        .removeWhere((notification) => notification.id == notificationId);
    _logger.info('Notification deleted: $notificationId');
  }

  Future<void> deleteAllNotifications() async {
    _logger.info('Deleting all notifications');
    _notifications.clear();
    _logger.info('All notifications deleted');
  }
}
