import 'package:flutter/material.dart';

import '../../../controllers/dashboard/notifications.dart';
import '../../../models/notification.dart';
import '../../widgets/notification_tile.dart';

late void Function(void Function()) changeState;

NotificationsController notificationsController = NotificationsController();

bool isLoading = true;
bool isShowingAllNotifications = false;

void initConst(void Function(void Function()) setState) {
  changeState = setState;

  isLoading = true;
  isShowingAllNotifications = false;

  getNotifications();
}

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

Widget buildNotificationsList(List<SmartShedNotification> notifications) {
  return ListView.separated(
    itemCount: notifications.length,
    itemBuilder: (context, index) {
      return NotificationTile(
        notification: notifications[index],
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
          changeState(() => {
                isLoading = true,
                isShowingAllNotifications = false,
              });
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
          await notificationsController.deleteAllNotifications();
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
  return const Column(
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
  );
}

Widget buildLoadReadNotificationsButton() {
  return ElevatedButton(
    onPressed: () {
      changeState(() => isShowingAllNotifications = true);
    },
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.more_horiz,
          color: Colors.white,
        ),
        SizedBox(width: 10),
        Text(
          'All Notifications',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

Widget buildBody() {
  return Column(
    children: [
      if (!isShowingAllNotifications)
        Expanded(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : notificationsController.unreadNotifications.isEmpty
                  ? noNotifications()
                  : buildNotificationsList(
                      notificationsController.unreadNotifications),
        ),
      if (notificationsController.readNotifications.isNotEmpty &&
          !isShowingAllNotifications)
        buildLoadReadNotificationsButton(),
      if (isShowingAllNotifications)
        Expanded(
          child: buildNotificationsList(
            notificationsController.readNotifications,
          ),
        ),
      const SizedBox(height: 20),
      buildButtons(),
      const SizedBox(height: 10),
    ],
  );
}
