import 'package:intl/intl.dart';

import '../controllers/settings/settings.dart';

class SmartShedNotification {
  String id;
  String contentEnglish;
  String contentHindi;
  DateTime createdAt;
  bool isRead;
  String? formId;
  String? userId;

  SmartShedNotification({
    required this.id,
    required this.contentEnglish,
    required this.contentHindi,
    required this.createdAt,
    required this.isRead,
    this.formId,
    this.userId,
  });

  factory SmartShedNotification.fromJson(Map<String, dynamic> json) {
    return SmartShedNotification(
      id: json['_id'],
      contentEnglish: json['contentEnglish'],
      contentHindi: json['contentHindi'],
      createdAt: DateTime.parse(json['createdAt']),
      isRead: json['isRead'],
      formId: json['formId'],
      userId: json['userId'],
    );
  }

  String get createdAtString =>
      DateFormat(UserSettingsController.dateTimeFormat).format(createdAt);
}
