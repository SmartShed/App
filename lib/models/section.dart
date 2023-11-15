class SmartShedSection {
  final String id;
  final String name;

  SmartShedSection({
    required this.id,
    required this.name,
  });

  factory SmartShedSection.fromJson(Map<String, dynamic> json) {
    return SmartShedSection(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
