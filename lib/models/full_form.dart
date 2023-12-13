import 'package:intl/intl.dart';

import 'question.dart';
import 'sub_form.dart';

class SmartShedForm {
  final String id;
  final String locoName;
  final String locoNumber;
  final String formID;
  final String title;
  final String descriptionEnglish;
  final String descriptionHindi;
  final List<SmartShedQuestion> questions;
  final List<SmartShedSubForm> subForms;
  final int submittedCount;
  final bool lockStatus;
  final List<String> access;
  final String createdBy;
  final List<dynamic> history;
  final DateTime createdAt;
  final DateTime updatedAt;

  SmartShedForm({
    required this.id,
    required this.locoName,
    required this.locoNumber,
    required this.formID,
    required this.title,
    required this.descriptionEnglish,
    required this.descriptionHindi,
    required this.questions,
    required this.subForms,
    required this.submittedCount,
    required this.lockStatus,
    required this.access,
    required this.createdBy,
    required this.history,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SmartShedForm.fromJson(Map<String, dynamic> json) {
    return SmartShedForm(
      id: json['_id'],
      locoName: json['locoName'],
      locoNumber: json['locoNumber'],
      formID: json['formID'],
      title: json['title'],
      descriptionEnglish: json['descriptionEnglish'],
      descriptionHindi: json['descriptionHindi'],
      questions: json['questions']
          .map<SmartShedQuestion>((question) =>
              SmartShedQuestion.fromJson(question as Map<String, dynamic>))
          .toList(),
      subForms: json['subForms']
          .map<SmartShedSubForm>((subForm) =>
              SmartShedSubForm.fromJson(subForm as Map<String, dynamic>))
          .toList(),
      submittedCount: json['submittedCount'],
      lockStatus: json['lockStatus'],
      access: json['access'].cast<String>(),
      createdBy: json['createdBy'],
      history: json['history'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  String get createdAtString =>
      DateFormat('dd MMM yyyy hh:mm a').format(createdAt);

  String get createdAtDateString => DateFormat('dd MMM yyyy').format(createdAt);

  String get updatedAtString =>
      DateFormat('dd MMM yyyy hh:mm a').format(updatedAt);
}
