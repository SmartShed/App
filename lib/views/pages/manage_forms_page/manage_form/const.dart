import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../../controllers/forms/opening.dart';
import '../../../../controllers/smartshed/smartshed.dart';
import '../../../../controllers/toast/toast.dart';
import '../../../../models/full_unopened_form.dart';
import '../../../localization/manage_manage_form.dart';
import '../../../localization/toast.dart';
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

  if (!context.mounted) return;
  if (form == null) {
    ToastController.error(
        Manage_ManageForm_LocaleData.failed_to_load.getString(context));
    return;
  }

  changeState(() => isFormLoading = false);
}

AppBar buildAppBar() {
  return AppBar(
    title: Text(
      Manage_ManageForm_LocaleData.title.getString(context),
      style: const TextStyle(
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
            Text(
              Manage_ManageForm_LocaleData.form_questions.getString(context),
              style: const TextStyle(
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                onPressed: addSubForm,
                child: Text(
                  Manage_ManageForm_LocaleData.add_sub_form.getString(context),
                  style: const TextStyle(
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
                    Manage_ManageForm_LocaleData.form_title.getString(context),
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
                    Manage_ManageForm_LocaleData.form_description
                        .getString(context),
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
              child: Text(
                Manage_ManageForm_LocaleData.add_question.getString(context),
                style: const TextStyle(
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
          context.formatString(
            Manage_ManageForm_LocaleData.question_number,
            [questionNumber],
          ),
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
      title: Text(Manage_ManageForm_LocaleData.add_question.getString(context)),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextField(
                hintText: Manage_ManageForm_LocaleData.question_in_english
                    .getString(context),
                controller: questionEnglishController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: Manage_ManageForm_LocaleData.question_in_hindi
                    .getString(context),
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
                ToastController.warning(Manage_ManageForm_LocaleData
                    .fill_atleast_one
                    .getString(context));
                return;
              }

              _addQuestion(
                questionEnglish,
                questionHindi,
                subForm,
              );

              Navigator.of(context).pop();
            },
            child: Text(
                Manage_ManageForm_LocaleData.add_question.getString(context))),
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
            child:
                Text(Manage_ManageForm_LocaleData.cancel.getString(context))),
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
    builder: (context) => LoadingDialog(
      title: Manage_ManageForm_LocaleData.adding_question.getString(context),
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

  if (addedQuestion == null) {
    ToastController.error(
        Toast_LocaleData.error_adding_question.getString(context));
    return;
  }

  ToastController.success(
      Toast_LocaleData.question_added_successfully.getString(context));

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
      title: Text(
        Manage_ManageForm_LocaleData.add_sub_form.getString(context),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextField(
                hintText: Manage_ManageForm_LocaleData.title_in_english
                    .getString(context),
                controller: titleEnglishController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: Manage_ManageForm_LocaleData.title_in_hindi
                    .getString(context),
                controller: titleHindiController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: Manage_ManageForm_LocaleData.note_optional
                    .getString(context),
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
                ToastController.warning(Manage_ManageForm_LocaleData
                    .fill_atleast_one
                    .getString(context));
                return;
              }

              _addSubForm(
                titleEnglish,
                titleHindi,
                note,
              );

              Navigator.of(context).pop();
            },
            child: Text(
                Manage_ManageForm_LocaleData.add_sub_form.getString(context))),
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
            child:
                Text(Manage_ManageForm_LocaleData.cancel.getString(context))),
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
    builder: (context) => LoadingDialog(
      title: Manage_ManageForm_LocaleData.adding_sub_form.getString(context),
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

  if (addedSubForm == null) {
    ToastController.error(
        Toast_LocaleData.error_adding_sub_form.getString(context));
    return;
  }

  ToastController.success(
      Toast_LocaleData.sub_form_added_successfully.getString(context));

  form!.subForms.add(addedSubForm);
  changeState(() {});
}
