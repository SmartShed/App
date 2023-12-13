class SmartShedUnopenedForm {
  final String id;
  final String title;
  final String descriptionEnglish;
  final String descriptionHindi;

  SmartShedUnopenedForm({
    required this.id,
    required this.title,
    required this.descriptionEnglish,
    required this.descriptionHindi,
  });

  factory SmartShedUnopenedForm.fromJson(Map<String, dynamic> json) {
    return SmartShedUnopenedForm(
      id: json['id'],
      title: json['title'],
      descriptionEnglish: json['descriptionEnglish'],
      descriptionHindi: json['descriptionHindi'],
    );
  }
}
