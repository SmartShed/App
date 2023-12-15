import 'package:intl/intl.dart';

import '../constants/settings.dart';

class SmartShedOpenedForm {
  String id;
  String title;
  String descriptionEnglish;
  String descriptionHindi;
  String locoName;
  String locoNumber;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  bool? lockStatus;

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
      id: json['id'],
      title: json['title'],
      descriptionEnglish: json['descriptionEnglish'],
      descriptionHindi: json['descriptionHindi'],
      locoName: json['locoName'],
      locoNumber: json['locoNumber'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      createdBy: json['createdBy'],
      lockStatus: json['lockStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'descriptionEnglish': descriptionEnglish,
      'descriptionHindi': descriptionHindi,
      'locoName': locoName,
      'locoNumber': locoNumber,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'createdBy': createdBy,
      'lockStatus': lockStatus,
    };
  }

  String get createdAtString =>
      DateFormat(SettingsConstants.dateTimeFormat).format(createdAt);

  String get createdAtDateString =>
      DateFormat(SettingsConstants.dateFormat).format(createdAt);

  String get updatedAtString =>
      DateFormat(SettingsConstants.dateTimeFormat).format(updatedAt);
}
