class SmartShedOpenedForm {
  String id;
  String title;
  String descriptionEnglish;
  String descriptionHindi;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  bool? lockStatus;

  SmartShedOpenedForm({
    required this.id,
    required this.title,
    required this.descriptionEnglish,
    required this.descriptionHindi,
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
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'createdBy': createdBy,
      'lockStatus': lockStatus,
    };
  }
}
