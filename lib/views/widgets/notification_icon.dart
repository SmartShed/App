import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onTap;
  final int notificationCount;

  const NotificationIcon({
    Key? key,
    this.onTap,
    required this.iconData,
    this.notificationCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 75,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 15,
              child: Icon(
                iconData,
                size: 25,
              ),
            ),
            Positioned(
              top: 7,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 0),
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.red,
                ),
                alignment: Alignment.center,
                child: notificationCount > 0
                    ? Text(notificationCount.toString())
                    : const SizedBox(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
