import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class MyDropdown extends StatelessWidget {
  final FocusNode focusNode;
  final String hintText;
  final TextEditingController controller;
  final List<String> items;

  const MyDropdown({
    Key? key,
    required this.focusNode,
    required this.hintText,
    required this.controller,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText,
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
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
          ),
        );
      }).toList(),
      onChanged: (value) {
        controller.text = value!;
      },
    );
  }
}
