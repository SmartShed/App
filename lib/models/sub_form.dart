import 'question.dart';

class SmartShedSubForm {
  final String id;
  final String subFormID;
  final String titleEnglish;
  final String titleHindi;
  final String? note;
  final List<SmartShedQuestion> questions;

  SmartShedSubForm({
    required this.id,
    required this.subFormID,
    required this.titleEnglish,
    required this.titleHindi,
    this.note,
    required this.questions,
  });

  factory SmartShedSubForm.fromJson(Map<String, dynamic> json) {
    return SmartShedSubForm(
      id: json['_id'],
      subFormID: json['subFormID'],
      titleEnglish: json['titleEnglish'],
      titleHindi: json['titleHindi'],
      note: json['note'],
      questions: json['questions']
          .map<SmartShedQuestion>((question) =>
              SmartShedQuestion.fromJson(question as Map<String, dynamic>))
          .toList(),
    );
  }
}
