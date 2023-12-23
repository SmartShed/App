class SmartShedUnopenedFormQuestion {
  final String id;
  final String textEnglish;
  final String textHindi;
  final String ansType;

  SmartShedUnopenedFormQuestion({
    required this.id,
    required this.textEnglish,
    required this.textHindi,
    required this.ansType,
  });

  factory SmartShedUnopenedFormQuestion.fromJson(Map<String, dynamic> json) {
    return SmartShedUnopenedFormQuestion(
      id: json['_id'],
      textEnglish: json['textEnglish'],
      textHindi: json['textHindi'],
      ansType: json['ansType'],
    );
  }
}

class SmartShedUnopenedFormSubForm {
  final String id;
  final String titleEnglish;
  final String titleHindi;
  final String? note;
  final List<SmartShedUnopenedFormQuestion> questions;

  SmartShedUnopenedFormSubForm({
    required this.id,
    required this.titleEnglish,
    required this.titleHindi,
    this.note,
    required this.questions,
  });

  factory SmartShedUnopenedFormSubForm.fromJson(Map<String, dynamic> json) {
    return SmartShedUnopenedFormSubForm(
      id: json['_id'],
      titleEnglish: json['titleEnglish'],
      titleHindi: json['titleHindi'],
      note: json['note'],
      questions: json['questions']
          .map<SmartShedUnopenedFormQuestion>((question) =>
              SmartShedUnopenedFormQuestion.fromJson(
                  question as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SmartShedFullUnopenedForm {
  final String id;
  final String title;
  final String descriptionEnglish;
  final String descriptionHindi;
  final List<SmartShedUnopenedFormQuestion> questions;
  final List<SmartShedUnopenedFormSubForm> subForms;

  SmartShedFullUnopenedForm({
    required this.id,
    required this.title,
    required this.descriptionEnglish,
    required this.descriptionHindi,
    required this.questions,
    required this.subForms,
  });

  factory SmartShedFullUnopenedForm.fromJson(Map<String, dynamic> json) {
    return SmartShedFullUnopenedForm(
      id: json['_id'],
      title: json['title'],
      descriptionEnglish: json['descriptionEnglish'],
      descriptionHindi: json['descriptionHindi'],
      questions: json['questions']
          .map<SmartShedUnopenedFormQuestion>((question) =>
              SmartShedUnopenedFormQuestion.fromJson(
                  question as Map<String, dynamic>))
          .toList(),
      subForms: json['subForms']
          .map<SmartShedUnopenedFormSubForm>((subForm) =>
              SmartShedUnopenedFormSubForm.fromJson(
                  subForm as Map<String, dynamic>))
          .toList(),
    );
  }
}
