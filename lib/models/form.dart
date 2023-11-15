class SmartShedForm {
  final String id;
  final String name;
  final String description;

  SmartShedForm({
    required this.id,
    required this.name,
    required this.description,
  });

  factory SmartShedForm.fromJson(Map<String, dynamic> json) {
    return SmartShedForm(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
