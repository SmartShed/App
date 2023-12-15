import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../models/user.dart';

late SmartShedUser user;

String get initials =>
    user.name.split(' ').map((e) => e[0]).join().toUpperCase();

AppBar buildAppBar() {
  return AppBar(
    title: const Text(
      'PROFILE',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    centerTitle: true,
  );
}

Widget buildProfile() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 40),
      CircleAvatar(
        radius: 75,
        backgroundColor: ColorConstants.primary,
        child: Text(
          initials,
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 20),
      const Text(
        'Name',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      ),
      const SizedBox(height: 5),
      Text(
        user.name,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 15),
      const Text(
        'Email',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      ),
      const SizedBox(height: 5),
      Text(
        user.email,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 15),
      const Text(
        'Position',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      ),
      const SizedBox(height: 5),
      Text(
        user.position.substring(0, 1).toUpperCase() +
            user.position.substring(1),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
