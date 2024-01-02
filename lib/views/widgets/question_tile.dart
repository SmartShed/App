import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import '../../constants/colors.dart';
import '../../models/question.dart';
import '../localization/form.dart';
import '../pages.dart';

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
  final ExpansionTileController _expansionTileController =
      ExpansionTileController();
  bool _isShowingHistory = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _expansionTileController.expand();
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
                  context.formatString(
                    Form_LocaleData.question_number.getString(context),
                    [widget.questionNumber],
                  ),
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
            ListTileTheme(
              contentPadding: const EdgeInsets.all(0),
              dense: true,
              minLeadingWidth: 0,
              minVerticalPadding: 0,
              child: ExpansionTile(
                shape: const Border(),
                backgroundColor: Colors.transparent,
                collapsedBackgroundColor: Colors.transparent,
                childrenPadding: const EdgeInsets.all(0),
                tilePadding: const EdgeInsets.all(0),
                trailing: const SizedBox(),
                collapsedIconColor: Colors.grey.shade700,
                initiallyExpanded: widget.question.isExpanded,
                onExpansionChanged: (value) => setState(() {
                  widget.question.isExpanded = value;
                }),
                controller: _expansionTileController,
                collapsedShape: const Border(),
                expandedAlignment: Alignment.centerLeft,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.question.isAnswered)
                      const Icon(
                        Icons.check_outlined,
                        color: ColorConstants.primary,
                        size: 20.0,
                      ),
                    const SizedBox(width: 10.0),
                    Text(
                      widget.question.isExpanded
                          ? Form_LocaleData.hide_answer.getString(context)
                          : Form_LocaleData.show_answer.getString(context),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      widget.question.isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.grey.shade700,
                      size: 12,
                    ),
                  ],
                ),
                children: [
                  TextFormField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
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
                        widget.question.isAnswered =
                            value.isEmpty ? false : true;
                      });
                    },
                  ),
                  if (widget.question.isAnswered &&
                      widget.question.history.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(
                              Pages.profile,
                              extra: widget.question.history.first.editedBy,
                            );
                          },
                          child: Text(
                            context.formatString(
                              Form_LocaleData.answerd_by_name_on_date_time
                                  .getString(context),
                              [
                                widget.question.history.first.editedBy
                                            .section ==
                                        null
                                    ? widget
                                        .question.history.first.editedBy.name
                                    : "${widget.question.history.first.editedBy.name} (${widget.question.history.first.editedBy.section})",
                                SmartShedQuestion.formattedDate(
                                  widget.question.history.first.editedAt,
                                ),
                              ],
                            ),
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (widget.question.history.length > 1)
                    ListTileTheme(
                      contentPadding: const EdgeInsets.all(0),
                      dense: true,
                      minLeadingWidth: 0,
                      minVerticalPadding: 0,
                      child: ExpansionTile(
                        shape: const Border(),
                        backgroundColor: Colors.transparent,
                        collapsedBackgroundColor: Colors.transparent,
                        childrenPadding: const EdgeInsets.all(0),
                        tilePadding: const EdgeInsets.all(0),
                        trailing: const SizedBox(),
                        collapsedIconColor: Colors.grey.shade700,
                        onExpansionChanged: (value) => setState(() {
                          _isShowingHistory = value;
                        }),
                        collapsedShape: const Border(),
                        expandedAlignment: Alignment.centerLeft,
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _isShowingHistory
                                  ? Form_LocaleData.hide_history
                                      .getString(context)
                                  : Form_LocaleData.show_history
                                      .getString(context),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(
                              _isShowingHistory
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.grey.shade700,
                              size: 12,
                            ),
                          ],
                        ),
                        children: [
                          _buildHistory(),
                        ],
                      ),
                    ),
                ],
              ),
            ),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  Form_LocaleData.edited_by.getString(context),
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  Form_LocaleData.edited_at.getString(context),
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 5.0),
              Expanded(
                flex: 2,
                child: Text(
                  Form_LocaleData.filled_answer.getString(context),
                  style: const TextStyle(
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
              if (widget.question.history[index].newValue == null) {
                return const SizedBox.shrink();
              }

              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(
                              Pages.profile,
                              extra: widget.question.history[index].editedBy,
                            );
                          },
                          child: Text(
                            widget.question.history[index].editedBy.section ==
                                    null
                                ? widget.question.history[index].editedBy.name
                                : "${widget.question.history[index].editedBy.name} (${widget.question.history[index].editedBy.section})",
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      Expanded(
                        child: Text(
                          SmartShedQuestion.formattedDate(
                            widget.question.history[index].editedAt,
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
                          widget.question.history[index].newValue!,
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
