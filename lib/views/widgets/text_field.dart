import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String initialValue;
  final bool obscureText;
  final bool autoFocus;
  final FocusNode? focusNode;
  final IconButton? suffixIcon;
  final void Function()? onEditingComplete;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final bool? isTextCentered;
  final TextCapitalization textCapitalization;
  final int? maxLines;

  const MyTextField({
    Key? key,
    this.controller,
    this.hintText = '',
    this.initialValue = '',
    this.obscureText = false,
    this.autoFocus = false,
    this.focusNode,
    this.suffixIcon,
    this.onEditingComplete,
    this.readOnly,
    this.keyboardType,
    this.textInputAction,
    this.onTap,
    this.onChanged,
    this.isTextCentered,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        focusNode: autoFocus ? null : focusNode,
        autofocus: autoFocus,
        textDirection: TextDirection.ltr,
        decoration: InputDecoration(
          hintText: hintText,
          isDense: true,
          suffixIcon: suffixIcon,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstants.primary,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        obscureText: obscureText,
        cursorColor: ColorConstants.primary,
        onEditingComplete: () => onEditingComplete?.call(),
        readOnly: readOnly ?? false,
        keyboardType: keyboardType ?? TextInputType.text,
        textInputAction: textInputAction,
        onTap: () => onTap?.call(),
        onChanged: (value) => onChanged?.call(value),
        textAlign: isTextCentered ?? false ? TextAlign.center : TextAlign.start,
        controller: initialValue.isNotEmpty
            ? TextEditingController(text: initialValue)
            : controller,
        maxLines: maxLines,
        textCapitalization: textCapitalization,
        autocorrect: false,
      ),
    );
  }
}
