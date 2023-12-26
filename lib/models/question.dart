import 'package:intl/intl.dart';

import '../controllers/settings/settings.dart';

class SmartShedQuestionHistory {
  String editedBy;
  String editedAt;
  String? section;
  String? oldValue;
  String? newValue;

  SmartShedQuestionHistory({
    required this.editedBy,
    required this.editedAt,
    this.section,
    this.oldValue,
    this.newValue,
  });

  factory SmartShedQuestionHistory.fromJson(Map<String, dynamic> json) {
    return SmartShedQuestionHistory(
      editedBy: json['editedBy'],
      editedAt: json['editedAt'],
      section: json['section'] ?? '',
      oldValue: json['oldValue'] ?? '',
      newValue: json['newValue'] ?? '',
    );
  }
}

class SmartShedQuestion {
  final String id;
  final String questionID;
  final String textEnglish;
  final String textHindi;
  final String ansType;
  bool isAnswered;
  String? ans;
  bool isExpanded = false;
  bool isAnsChanged = false;

  List<SmartShedQuestionHistory> history = [];

  SmartShedQuestion({
    required this.id,
    required this.questionID,
    required this.textEnglish,
    required this.textHindi,
    required this.ansType,
    required this.isAnswered,
    this.ans,
  });

  factory SmartShedQuestion.fromJson(Map<String, dynamic> json) {
    return SmartShedQuestion(
      id: json['_id'],
      questionID: json['questionID'],
      textEnglish: json['textEnglish'],
      textHindi: json['textHindi'],
      ansType: json['ansType'],
      isAnswered: json['isAnswered'],
      ans: json['ans'],
    );
  }

  static String formattedDate(String date) {
    return DateFormat(UserSettingsController.dateTimeFormat)
        .format(DateTime.parse(date));
  }
}
