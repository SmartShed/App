import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool autoFocus;
  final FocusNode? focusNode;
  final IconButton? suffixIcon;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.autoFocus = false,
    this.focusNode,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        focusNode: autoFocus ? null : focusNode,
        autofocus: autoFocus,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstants.primary,
            ),
          ),
        ),
        obscureText: obscureText,
        onEditingComplete: () => FocusScope.of(context).requestFocus(focusNode),
      ),
    );
  }
}
