import 'package:intl/intl.dart';

import '../controllers/settings/settings.dart';
import 'question.dart';
import 'sub_form.dart';
import 'user.dart';

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
  final SmartShedUser createdBy;
  final List<dynamic> history;
  final DateTime createdAt;
  final DateTime updatedAt;

  final bool isSignedBySupervisor;
  final bool isSignedByAuthority;

  final SmartShedUser? signedSupervisor;
  final SmartShedUser? signedAuthority;

  final DateTime? signedSupervisorAt;
  final DateTime? signedAuthorityAt;

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
    required this.isSignedBySupervisor,
    required this.isSignedByAuthority,
    this.signedSupervisor,
    this.signedAuthority,
    this.signedSupervisorAt,
    this.signedAuthorityAt,
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
      createdBy: SmartShedUser.fromJson(json['createdBy']),
      history: json['history'],
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
      updatedAt: DateTime.parse(json['updatedAt']).toLocal(),
      isSignedBySupervisor: json['signedBySupervisor']['isSigned'],
      isSignedByAuthority: json['signedByAuthority']['isSigned'],
      signedSupervisor: json['signedBySupervisor']['supervisor'] != null
          ? SmartShedUser.fromJson(
              json['signedBySupervisor']['supervisor'] as Map<String, dynamic>)
          : null,
      signedAuthority: json['signedByAuthority']['authority'] != null
          ? SmartShedUser.fromJson(
              json['signedByAuthority']['authority'] as Map<String, dynamic>)
          : null,
      signedSupervisorAt: json['signedBySupervisor']['signedAt'] != null
          ? DateTime.parse(json['signedBySupervisor']['signedAt']).toLocal()
          : null,
      signedAuthorityAt: json['signedByAuthority']['signedAt'] != null
          ? DateTime.parse(json['signedByAuthority']['signedAt']).toLocal()
          : null,
    );
  }

  String get createdAtString =>
      DateFormat(UserSettingsController.dateTimeFormat).format(createdAt);

  String get createdAtDateString =>
      DateFormat(UserSettingsController.dateFormat).format(createdAt);

  String get updatedAtString =>
      DateFormat(UserSettingsController.dateTimeFormat).format(updatedAt);

  String get signedSupervisorAtString => signedSupervisorAt != null
      ? DateFormat(UserSettingsController.dateTimeFormat)
          .format(signedSupervisorAt!)
      : '';

  String get signedAuthorityAtString => signedAuthorityAt != null
      ? DateFormat(UserSettingsController.dateTimeFormat)
          .format(signedAuthorityAt!)
      : '';
}
