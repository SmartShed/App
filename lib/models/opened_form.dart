class OpenedSmartShedForm {
  static const String UNKOWN_CREATOR = 'Unknown';

  String id;
  String name;
  String description;
  String status;
  String formId;
  String sectionId;
  DateTime createdAt;
  String createdBy;

  OpenedSmartShedForm({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.formId,
    required this.sectionId,
    required this.createdAt,
    this.createdBy = UNKOWN_CREATOR,
  });

  factory OpenedSmartShedForm.fromJson(Map<String, dynamic> json) {
    return OpenedSmartShedForm(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      formId: json['formId'],
      sectionId: json['sectionId'],
      createdAt: DateTime.parse(json['createdAt']),
      createdBy:
          json.containsKey('createdBy') ? json['createdBy'] : UNKOWN_CREATOR,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
      'formId': formId,
      'sectionId': sectionId,
      'createdAt': createdAt.toIso8601String(),
      if (createdBy != UNKOWN_CREATOR) 'createdBy': createdBy,
    };
  }

  bool get isCreatetByEmpty => createdBy == UNKOWN_CREATOR;
  bool get isCreatedByNotEmpty => !isCreatetByEmpty;
}
