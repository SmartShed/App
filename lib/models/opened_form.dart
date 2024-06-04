import 'package:intl/intl.dart';

import '../controllers/settings/settings.dart';
import 'user.dart';

class SmartShedOpenedForm {
  final String id;
  final String title;
  final String descriptionEnglish;
  final String descriptionHindi;
  final String locoName;
  final String locoNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SmartShedUser createdBy;
  final bool? lockStatus;

  SmartShedOpenedForm({
    required this.id,
    required this.title,
    required this.descriptionEnglish,
    required this.descriptionHindi,
    required this.locoName,
    required this.locoNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    this.lockStatus,
  });

  factory SmartShedOpenedForm.fromJson(Map<String, dynamic> json) {
    return SmartShedOpenedForm(
      id: json['_id'] ?? json['id'],
      title: json['title'],
      descriptionEnglish: json['descriptionEnglish'],
      descriptionHindi: json['descriptionHindi'],
      locoName: json['locoName'],
      locoNumber: json['locoNumber'],
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
      updatedAt: DateTime.parse(json['updatedAt']).toLocal(),
      createdBy: SmartShedUser.fromJson(json['createdBy']),
      lockStatus: json['lockStatus'],
    );
  }

  String get createdAtString =>
      DateFormat(UserSettingsController.dateTimeFormat).format(createdAt);

  String get createdAtDateString =>
      DateFormat(UserSettingsController.dateFormat).format(createdAt);

  String get updatedAtString =>
      DateFormat(UserSettingsController.dateTimeFormat).format(updatedAt);
}
