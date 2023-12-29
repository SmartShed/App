// ignore_for_file: constant_identifier_names

mixin Notifications_LocaleData {
  static const String title = 'notifications_title';
  static const String refresh = 'notifications_refresh';
  static const String delete_all = 'notifications_delete_all';
  static const String no_notifications = 'notifications_no_notifications';
  static const String all_notifications = 'notifications_all_notifications';
  static const String new_notifications = 'notifications_new_notifications';

  // notification_tile
  static const String delete_notification =
      'notification_tile_delete_notification';
  static const String ask_delete_notification =
      'notification_tile_ask_delete_notification';
  static const String yes = 'notification_tile_yes';
  static const String no = 'notification_tile_no';

  static const Map<String, dynamic> EN = {
    title: 'NOTIFICATIONS',
    refresh: 'Refresh',
    delete_all: 'Delete All',
    no_notifications: 'No Notifications',
    all_notifications: 'All Notifications',
    new_notifications: 'New Notifications',

    // notification_tile
    delete_notification: 'Delete Notification',
    ask_delete_notification:
        'Are you sure you want to delete this notification?',
    yes: 'Yes',
    no: 'No',
  };

  static const Map<String, dynamic> HI = {
    title: 'सूचनाएं',
    refresh: 'ताज़ा करें',
    delete_all: 'सभी हटाएं',
    no_notifications: 'कोई सूचनाएं नहीं',
    all_notifications: 'सभी सूचनाएं',
    new_notifications: 'नई सूचनाएं',

    // notification_tile
    delete_notification: 'सूचना हटाएं',
    ask_delete_notification: 'क्या आप वाकई इस सूचना को हटाना चाहते हैं?',
    yes: 'हाँ',
    no: 'नहीं',
  };
}
