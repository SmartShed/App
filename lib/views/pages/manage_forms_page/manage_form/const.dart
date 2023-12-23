import 'package:flutter/material.dart';

import '../../../../models/full_unopened_form.dart';

late String formId;
late SmartShedFullUnopenedForm? form;

late bool isFormLoading;

late BuildContext context;
late void Function(void Function()) changeState;

void initConst(
  String formID,
  void Function(void Function()) setState,
) {
  formId = formID;
  changeState = setState;

  isFormLoading = true;
  initForm();
}

void disposeConst() {}

void initForm() async {
  changeState(() => isFormLoading = true);
  // TODO: Add API call to get form
  changeState(() => isFormLoading = false);
}

AppBar buildAppBar() {
  return AppBar(
    title: const Text(
      'MANAGE FORM',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    centerTitle: true,
  );
}

Widget buildBody() {
  return isFormLoading
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : Column(
          children: [
            buildTopInfoBar(),
            const SizedBox(height: 10),
            const Text(
              "Form Questions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            buildQuestionsContainer(form!.questions, null),
            ...form!.subForms.map(
              (subForm) => buildQuestionsContainer(
                subForm.questions,
                subForm,
              ),
            ),
            const SizedBox(height: 40),
          ],
        );
}

Widget buildTopInfoBar() {
  return Container(
    padding: const EdgeInsets.all(8),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    form!.descriptionEnglish,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    form!.descriptionHindi,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildQuestionsContainer(
  List<SmartShedUnopenedFormQuestion> questions,
  SmartShedUnopenedFormSubForm? subForm,
) {
  if (questions.isEmpty) return const SizedBox();

  return Container(
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.only(bottom: 10),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Sub Form Title
          if (subForm != null)
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  subForm.titleEnglish.isEmpty
                      ? const SizedBox()
                      : Text(
                          subForm.titleEnglish,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                  subForm.titleHindi.isEmpty || subForm.titleEnglish.isEmpty
                      ? const SizedBox()
                      : const SizedBox(height: 5),
                  subForm.titleHindi.isEmpty
                      ? const SizedBox()
                      : Text(
                          subForm.titleHindi,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                ],
              ),
            ),
          const SizedBox(height: 20),
          // Questions
          ...questions.map(
            (question) => Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: buildQuestion(
                question,
                questions.indexOf(question) + 1,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildQuestion(
  SmartShedUnopenedFormQuestion question,
  int questionNumber,
) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white70,
      border: Border.all(color: Colors.grey.shade500),
      borderRadius: BorderRadius.circular(3.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 2.0,
          spreadRadius: 2.0,
          offset: const Offset(0.0, 1.0),
        ),
      ],
    ),
    padding: const EdgeInsets.all(16.0),
    margin: const EdgeInsets.only(bottom: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Q$questionNumber.",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question.textEnglish,
                style: const TextStyle(
                  fontSize: 15.0,
                ),
              ),
              if (question.textHindi.isNotEmpty)
                Text(
                  question.textHindi,
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
