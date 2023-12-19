// SmartShedNotification({
//   required this.id,
//   required this.contentEnglish,
//   required this.contentHindi,
//   required this.createdAt,
//   required this.isRead,
//   required this.formId,
// });

import 'package:flutter/material.dart';

import '../../models/notification.dart';

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
              title: const Text('Delete Notification'),
              content: const Text(
                'Are you sure you want to delete this notification?',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // Add rounded corners
          color: Colors.white,
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
            onNotificationMarkAsRead(notification.id);
          },
        ),
      ),
    );
  }
}
