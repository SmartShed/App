class OpenedSmartShedForm {
  static const String UNKOWN_CREATOR = 'Unknown';

  String id;
  String title;
  String description;
  // String status;
  // String formId;
  // String sectionId;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;

  OpenedSmartShedForm({
    required this.id,
    required this.title,
    required this.description,
    // required this.status,
    // required this.formId,
    // required this.sectionId,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy = UNKOWN_CREATOR,
  });

  factory OpenedSmartShedForm.fromJson(Map<String, dynamic> json) {
    return OpenedSmartShedForm(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      // status: json['status'],
      // formId: json['formId'],
      // sectionId: json['sectionId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      createdBy:
          json.containsKey('createdBy') ? json['createdBy'] : UNKOWN_CREATOR,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'description': description,
      // 'status': status,
      // 'formId': formId,
      // 'sectionId': sectionId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      if (createdBy != UNKOWN_CREATOR) 'createdBy': createdBy,
    };
  }

  bool get isCreatetByEmpty => createdBy == UNKOWN_CREATOR;
  bool get isCreatedByNotEmpty => !isCreatetByEmpty;
}
