class SmartShedSection {
  final String id;
  final String title;

  SmartShedSection({
    required this.id,
    required this.title,
  });

  factory SmartShedSection.fromJson(Map<String, dynamic> json) {
    return SmartShedSection(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
