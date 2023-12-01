class SmartShedForm {
  final String id;
  final String title;
  final String descriptionEnglish;
  final String descriptionHindi;

  SmartShedForm({
    required this.id,
    required this.title,
    required this.descriptionEnglish,
    required this.descriptionHindi,
  });

  factory SmartShedForm.fromJson(Map<String, dynamic> json) {
    return SmartShedForm(
      id: json['id'],
      title: json['title'],
      descriptionEnglish: json['descriptionEnglish'],
      descriptionHindi: json['descriptionHindi'],
    );
  }
}
