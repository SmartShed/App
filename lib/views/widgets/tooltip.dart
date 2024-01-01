import 'package:flutter/material.dart';

import 'text_scroll.dart';

class MyTooltip extends StatefulWidget {
  final String? text;
  final String? tooltipText;
  final TextStyle? textStyle;
  final int maxLines;
  final List<String>? texts;
  final void Function()? onDoubleTap;
  final void Function()? onTap;

  const MyTooltip({
    Key? key,
    this.text,
    this.tooltipText,
    this.textStyle,
    this.maxLines = 1,
    this.texts,
    this.onDoubleTap,
    this.onTap,
  }) : super(key: key);

  @override
  State<MyTooltip> createState() => _MyTooltipState();
}

class _MyTooltipState extends State<MyTooltip> {
  bool _clicked = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: _getToolTipText(),
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
      child: GestureDetector(
        onTap: () {
          setState(() => _clicked = true);
          if (widget.onTap != null) widget.onTap!();
        },
        onDoubleTap: widget.onDoubleTap,
        onLongPress: widget.onDoubleTap,
        child: widget.text != null ? _showText() : _showTexts(),
      ),
    );
  }

  String _getToolTipText() {
    if (widget.tooltipText != null) return widget.tooltipText!;
    if (widget.text != null) return widget.text!;
    return widget.texts!.join('\n');
  }

  Widget _showText() => _clicked
      ? TextScroll(
          widget.text!,
          style: widget.textStyle ?? const TextStyle(),
          mode: TextScrollMode.bouncing,
          numberOfReps: 1,
          pauseBetween: const Duration(milliseconds: 1000),
          velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
          pauseOnBounce: const Duration(milliseconds: 1000),
          onScrollComplete: () {
            setState(() => _clicked = false);
          },
          textAlign: TextAlign.left,
        )
      : Text(
          widget.text!,
          style: widget.textStyle ?? const TextStyle(),
          overflow: TextOverflow.ellipsis,
          maxLines: widget.maxLines,
          textAlign: TextAlign.left,
        );

  Widget _showTexts() => _clicked
      ? TextScroll(
          widget.texts!.join('\n'),
          style: widget.textStyle ?? const TextStyle(),
          mode: TextScrollMode.bouncing,
          numberOfReps: 1,
          pauseBetween: const Duration(milliseconds: 1000),
          velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
          pauseOnBounce: const Duration(milliseconds: 1000),
          onScrollComplete: () {
            setState(() => _clicked = false);
          },
          textAlign: TextAlign.left,
        )
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.texts!
              .map((text) => Text(
                    text,
                    style: widget.textStyle ?? const TextStyle(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: widget.maxLines,
                    textAlign: TextAlign.left,
                  ))
              .toList(),
        );
}
