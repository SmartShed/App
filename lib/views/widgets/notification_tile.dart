import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import '../../models/notification.dart';
import '../localization/notifications.dart';
import '../pages.dart';

class NotificationTile extends StatelessWidget {
  final SmartShedNotification notification;
  final void Function(String notificationId) onNotificationDelete;
  final void Function(String notificationId) onNotificationMarkAsRead;

  const NotificationTile({
    Key? key,
    required this.notification,
    required this.onNotificationDelete,
    required this.onNotificationMarkAsRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
        ),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (_) {
        onNotificationDelete(notification.id);
      },
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(Notifications_LocaleData.delete_notification
                  .getString(context)),
              content: Text(
                Notifications_LocaleData.ask_delete_notification
                    .getString(context),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(Notifications_LocaleData.no.getString(context)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(Notifications_LocaleData.yes.getString(context)),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: notification.isRead ? Colors.lightBlue.shade100 : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.createdAtString,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                notification.contentEnglish,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                notification.contentHindi,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            if (notification.formId != null) {
              GoRouter.of(context).push("${Pages.form}/${notification.formId}");
            } else if (notification.userId != null) {
              GoRouter.of(context)
                  .push("${Pages.profile}/${notification.userId}");
            }

            onNotificationMarkAsRead(notification.id);
          },
        ),
      ),
    );
  }
}
