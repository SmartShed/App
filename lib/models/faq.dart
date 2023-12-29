class SmartShedFAQ {
  final String? questionEnglish;
  final String? questionHindi;
  final String? answerEnglish;
  final String? answerHindi;

  SmartShedFAQ({
    this.questionEnglish,
    this.questionHindi,
    this.answerEnglish,
    this.answerHindi,
  });

  factory SmartShedFAQ.fromJson(Map<String, dynamic> json) {
    return SmartShedFAQ(
      questionEnglish: json['questionEnglish'],
      questionHindi: json['questionHindi'],
      answerEnglish: json['answerEnglish'],
      answerHindi: json['answerHindi'],
    );
  }
}
