import 'package:intl/intl.dart';

import '../constants/settings.dart';

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

  // History
  /*
  [
    {
      'editedBy': 'Name',
      'editedAt': 'Date',
      'oldAns': 'Old Answer',
      'newAns': 'New Answer',
    },
    {
      'editedBy': 'Name',
      'editedAt': 'Date',
      'oldAns': 'Old Answer',
      'newAns': 'New Answer',
    },
  ]
  */

  List<Map<String, dynamic>> history = [];

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
    return DateFormat(SettingsConstants.dateTimeFormat)
        .format(DateTime.parse(date));
  }
}
