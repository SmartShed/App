import 'package:flutter/material.dart';
import 'package:smartshed/controllers/dashboard/notifications.dart';
import 'package:smartshed/views/widgets/notification_tile.dart';

late void Function(void Function()) changeState;

NotificationsController notificationsController = NotificationsController();

bool isLoading = true;

void getNotifications() async {
  changeState(() => isLoading = true);
  await notificationsController.fetchNotifications();
  changeState(() => isLoading = false);
}

AppBar buildAppBar() {
  return AppBar(
    title: const Text(
      'Notifications',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    centerTitle: true,
  );
}

Widget buildNotificationsList() {
  return ListView.separated(
    itemCount: notificationsController.unreadNotificationsCount,
    itemBuilder: (context, index) {
      return NotificationTile(
        notification: notificationsController.notifications[index],
        onNotificationDelete: (notificationId) {
          notificationsController.deleteNotification(notificationId);
          changeState(() {});
        },
        onNotificationMarkAsRead: (notificationId) {
          notificationsController.markNotificationAsRead(notificationId);
          changeState(() {});
        },
      );
    },
    separatorBuilder: (context, index) =>
        const Divider(color: Colors.transparent),
  );
}

Widget buildButtons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ElevatedButton(
        onPressed: () async {
          changeState(() => isLoading = true);
          await notificationsController.fetchNotifications();
          changeState(() => isLoading = false);
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              'Refresh',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      ElevatedButton(
        onPressed: () async {
          notificationsController.notifications.clear();
          changeState(() {});
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              'Delete All',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget noNotifications() {
  return const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.notifications_off,
          size: 100,
          color: Colors.grey,
        ),
        SizedBox(height: 20),
        Text(
          'No notifications',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
}

Widget buildBody() {
  return Column(
    children: [
      Expanded(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : notificationsController.notifications.isEmpty
                ? noNotifications()
                : buildNotificationsList(),
      ),
      const SizedBox(height: 20),
      buildButtons(),
      const SizedBox(height: 10),
    ],
  );
}
