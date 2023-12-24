import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../controllers/forms/opening.dart';
import '../../../../controllers/smartshed/smartshed.dart';
import '../../../../controllers/toast/toast.dart';
import '../../../../models/full_unopened_form.dart';
import '../../../widgets/loading_dialog.dart';
import '../../../widgets/text_field.dart';

late String formId;
late SmartShedFullUnopenedForm? form;

// Form Questions
List<SmartShedUnopenedFormQuestion> formQuestions = [];

// Sub Form ID -> Sub Form Questions
Map<String, List<SmartShedUnopenedFormQuestion>> subFormQuestions = {};

late bool isFormLoading;

late BuildContext context;
late void Function(void Function()) changeState;

void initConst(
  String formID,
  void Function(void Function()) setState,
) {
  formId = formID;
  changeState = setState;

  formQuestions = [];
  subFormQuestions = {};

  isFormLoading = true;
  initForm();
}

void disposeConst() {}

void initForm() async {
  changeState(() => isFormLoading = true);
  form = await FormOpeningController.getUnopenedForm(formId);

  if (form == null) {
    ToastController.error('Failed to load form');
    return;
  }

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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                onPressed: addSubForm,
                child: Text(
                  "Add Sub Form",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        );
}

Widget buildTopInfoBar() {
  return Container(
    width: double.infinity,
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
                    "Title",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    form!.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
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
  return Container(
    width: double.infinity,
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
          if (questions.isNotEmpty) const SizedBox(height: 20),
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
          // New Questions
          // Form Questions
          if (subForm == null)
            ...formQuestions.map(
              (question) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: buildQuestion(
                  question,
                  questions.length + formQuestions.indexOf(question) + 1,
                ),
              ),
            ),
          // Sub Form Questions
          if (subForm != null)
            if (subFormQuestions[subForm.id] != null)
              ...subFormQuestions[subForm.id]!.map(
                (question) => Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: buildQuestion(
                    question,
                    questions.length +
                        subFormQuestions[subForm.id]!.indexOf(question) +
                        1,
                  ),
                ),
              ),
          // Add Question Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ElevatedButton(
              onPressed: () {
                addQuestion(subForm);
              },
              child: const Text(
                "Add Question",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
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

void addQuestion(SmartShedUnopenedFormSubForm? subForm) {
  TextEditingController questionEnglishController = TextEditingController();
  TextEditingController questionHindiController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text("Add Question"),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextField(
                hintText: "Question in English",
                controller: questionEnglishController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: "Question in Hindi",
                controller: questionHindiController,
              ),
            ],
          ),
        ),
      ),
      actions: [
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey.shade100),
            side: MaterialStateProperty.all(
              const BorderSide(color: Colors.grey),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          onPressed: () {
            String questionEnglish = questionEnglishController.text.trim();
            String questionHindi = questionHindiController.text.trim();

            if (questionEnglish.isEmpty && questionHindi.isEmpty) {
              ToastController.warning('Please fill at least one field');
              return;
            }

            _addQuestion(
              questionEnglish,
              questionHindi,
              subForm,
            );

            Navigator.of(context).pop();
          },
          child: const Text("Add Question"),
        ),
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey.shade100),
            side: MaterialStateProperty.all(
              const BorderSide(color: Colors.grey),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ],
    ),
  );
}

void _addQuestion(
  String questionEnglish,
  String questionHindi,
  SmartShedUnopenedFormSubForm? subForm,
) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const LoadingDialog(
      title: "Adding Question...",
    ),
  );

  final SmartShedUnopenedFormQuestion? addedQuestion =
      await SmartShedController.addQuestion(
    questionEnglish,
    questionHindi,
    'string',
    form!.id,
    subForm?.id,
  );

  if (!context.mounted) return;
  GoRouter.of(context).pop();

  if (addedQuestion == null) return;

  if (subForm == null) {
    formQuestions.add(addedQuestion);
  } else {
    if (subFormQuestions[subForm.id] == null) {
      subFormQuestions[subForm.id] = [];
    }

    subFormQuestions[subForm.id]!.add(addedQuestion);
  }

  changeState(() {});
}

void addSubForm() {
  TextEditingController titleEnglishController = TextEditingController();
  TextEditingController titleHindiController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text("Add Sub Form"),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextField(
                hintText: "Title in English",
                controller: titleEnglishController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: "Title in Hindi",
                controller: titleHindiController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: "Note (Optional)",
                controller: noteController,
              ),
            ],
          ),
        ),
      ),
      actions: [
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey.shade100),
            side: MaterialStateProperty.all(
              const BorderSide(color: Colors.grey),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          onPressed: () {
            String titleEnglish = titleEnglishController.text.trim();
            String titleHindi = titleHindiController.text.trim();
            String note = noteController.text.trim();

            if (titleEnglish.isEmpty && titleHindi.isEmpty) {
              ToastController.warning('Please fill at least one field');
              return;
            }

            _addSubForm(
              titleEnglish,
              titleHindi,
              note,
            );

            Navigator.of(context).pop();
          },
          child: const Text("Add Sub Form"),
        ),
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey.shade100),
            side: MaterialStateProperty.all(
              const BorderSide(color: Colors.grey),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
      ],
    ),
  );
}

void _addSubForm(
  String titleEnglish,
  String titleHindi,
  String note,
) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const LoadingDialog(
      title: "Adding Sub Form...",
    ),
  );

  SmartShedUnopenedFormSubForm? addedSubForm =
      await SmartShedController.addSubForm(
    titleHindi,
    titleEnglish,
    note,
    form!.id,
  );

  if (!context.mounted) return;
  GoRouter.of(context).pop();

  if (addedSubForm == null) return;

  form!.subForms.add(addedSubForm);

  changeState(() {});
}
