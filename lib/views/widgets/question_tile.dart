import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../models/question.dart';

class QuestionTile extends StatefulWidget {
  final Key qKey;
  final SmartShedQuestion question;
  final int questionNumber;

  const QuestionTile({
    required this.qKey,
    required this.question,
    required this.questionNumber,
  }) : super(key: qKey);

  @override
  State<QuestionTile> createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.question.isExpanded = true;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(color: Colors.grey.shade500),
          borderRadius: BorderRadius.circular(3.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 2.0,
              spreadRadius: 2.0,
              offset: const Offset(0.0, 1.0),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Q${widget.questionNumber}.",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.question.textEnglish,
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      if (widget.question.textHindi.isNotEmpty)
                        Text(
                          widget.question.textHindi,
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.question.isAnswered)
                  const Icon(
                    Icons.check_outlined,
                    color: ColorConstants.primary,
                    size: 20.0,
                  ),
                const SizedBox(width: 10.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.question.isExpanded = !widget.question.isExpanded;
                    });
                  },
                  child: Text(
                    widget.question.isExpanded ? "Hide Answer" : "Show Answer",
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.question.isExpanded = !widget.question.isExpanded;
                    });
                  },
                  child: Icon(
                    widget.question.isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                    size: 20.0,
                  ),
                ),
              ],
            ),
            if (widget.question.isExpanded)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  maxLines: null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade500),
                      gapPadding: 0.0,
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade900),
                      gapPadding: 0.0,
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    contentPadding: const EdgeInsets.all(10.0),
                  ),
                  initialValue: widget.question.ans,
                  onChanged: (value) {
                    widget.question.ans = value;

                    setState(() {
                      widget.question.isAnswered = value.isEmpty ? false : true;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
