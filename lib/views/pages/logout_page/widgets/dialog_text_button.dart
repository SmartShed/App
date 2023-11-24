import 'package:flutter/material.dart';

class DialogTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double paddingForBox;
  final double textButtonPaddingForBox;

  const DialogTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.paddingForBox,
    required this.textButtonPaddingForBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingForBox),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.white.withOpacity(0.8);
              }
              return Colors.white;
            },
          ),
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(
              color: Colors.grey,
            ),
          ),
          shadowColor: MaterialStateProperty.all<Color>(
            Colors.grey.withOpacity(0.2),
          ),
          elevation: MaterialStateProperty.all<double>(2),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: textButtonPaddingForBox),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
