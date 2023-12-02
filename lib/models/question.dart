class SmartShedQuestion {
  final String id;
  final String textEnglish;
  final String textHindi;
  final String ansType;
  final bool isAnswered;
  final String? ans;

  SmartShedQuestion({
    required this.id,
    required this.textEnglish,
    required this.textHindi,
    required this.ansType,
    required this.isAnswered,
    this.ans,
  });

  factory SmartShedQuestion.fromJson(Map<String, dynamic> json) {
    return SmartShedQuestion(
      id: json['id'],
      textEnglish: json['textEnglish'],
      textHindi: json['textHindi'],
      ansType: json['ansType'],
      isAnswered: json['isAnswered'],
      ans: json['ans'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'textEnglish': textEnglish,
      'textHindi': textHindi,
      'ansType': ansType,
      'isAnswered': isAnswered,
      'ans': ans,
    };
  }
}
