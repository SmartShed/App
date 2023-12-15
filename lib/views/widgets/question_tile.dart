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
  bool _isShowingHistory = false;

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
                    widget.question.isAnsChanged = true;

                    setState(() {
                      widget.question.isAnswered = value.isEmpty ? false : true;
                    });
                  },
                ),
              ),
            if (widget.question.isExpanded &&
                widget.question.isAnswered &&
                widget.question.history.isNotEmpty)
              // Show answered by and answered at
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    "Answered by ${widget.question.history.first['editedBy']} on ${SmartShedQuestion.formattedDate(widget.question.history.first['editedAt'])}",
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            if (widget.question.isExpanded &&
                widget.question.history.length > 1)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isShowingHistory = !_isShowingHistory;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _isShowingHistory ? "Hide History" : "Show History",
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        _isShowingHistory
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            if (widget.question.isExpanded && _isShowingHistory)
              _buildHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildHistory() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Edited By",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  "Edited At",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              Expanded(
                flex: 2,
                child: Text(
                  "Filled Answer",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey.shade900,
            thickness: 0.5,
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0.0),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.question.history.length,
            itemBuilder: (context, index) {
              if (widget.question.history[index]['newAns'] == null) {
                return const SizedBox.shrink();
              }

              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.question.history[index]['editedBy'],
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      Expanded(
                        child: Text(
                          SmartShedQuestion.formattedDate(
                            widget.question.history[index]['editedAt'],
                          ),
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      Expanded(
                        flex: 2,
                        child: Text(
                          widget.question.history[index]['newAns'],
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (index != widget.question.history.length - 1)
                    Divider(
                      color: Colors.grey.shade500,
                      thickness: 0.5,
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
