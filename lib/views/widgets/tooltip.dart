import 'package:flutter/material.dart';

class MyTooltip extends StatelessWidget {
  final String text;
  final String? tooltipText;

  final TextStyle? textStyle;

  const MyTooltip({
    Key? key,
    required this.text,
    this.tooltipText,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipText ?? text,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A1E7D77),
            offset: Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -2,
          ),
          BoxShadow(
            color: Color(0x171E7D77),
            offset: Offset(0, 12),
            blurRadius: 16,
            spreadRadius: -4,
          ),
        ],
      ),
      waitDuration: const Duration(milliseconds: 500),
      child: Text(
        text,
        style: textStyle ?? const TextStyle(),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
