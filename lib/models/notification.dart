import 'package:intl/intl.dart';

import '../constants/settings.dart';

class SmartShedNotification {
  String id;
  String contentEnglish;
  String contentHindi;
  DateTime createdAt;
  bool isRead;
  String formId;

  SmartShedNotification({
    required this.id,
    required this.contentEnglish,
    required this.contentHindi,
    required this.createdAt,
    required this.isRead,
    required this.formId,
  });

  factory SmartShedNotification.fromJson(Map<String, dynamic> json) {
    return SmartShedNotification(
      id: json['id'],
      contentEnglish: json['contentEnglish'],
      contentHindi: json['contentHindi'],
      createdAt: DateTime.parse(json['createdAt']),
      isRead: json['isRead'],
      formId: json['formId'],
    );
  }

  String get createdAtString =>
      DateFormat(SettingsConstants.dateTimeFormat).format(createdAt);
}
