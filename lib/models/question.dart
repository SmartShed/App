class Question {
  final String id;
  final String text;
  final String type;

  Question({
    required this.id,
    required this.text,
    required this.type,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      text: json['text'],
      type: json['type'],
    );
  }
}
