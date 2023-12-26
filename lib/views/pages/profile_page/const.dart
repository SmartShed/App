import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../constants/colors.dart';
import '../../../models/user.dart';
import '../../localization/profile.dart';

late BuildContext context;
late SmartShedUser user;

String get initials =>
    user.name.split(' ').map((e) => e[0]).join().toUpperCase();

AppBar buildAppBar() {
  return AppBar(
    title: Text(
      Profile_LocaleData.title.getString(context),
      style: const TextStyle(
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
      Text(
        Profile_LocaleData.name.getString(context),
        style: const TextStyle(
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
      Text(
        Profile_LocaleData.email.getString(context),
        style: const TextStyle(
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
      Text(
        Profile_LocaleData.position.getString(context),
        style: const TextStyle(
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
