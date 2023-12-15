import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
    title: const Text(
      'MANAGE FORMS',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    centerTitle: true,
  );
}

Widget buildBody() {
  return const Center(
    child: Text(
      'No forms yet!',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
