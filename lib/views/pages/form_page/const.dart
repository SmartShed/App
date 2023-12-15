import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/forms/answering.dart';
import '../../../controllers/forms/opening.dart';
import '../../../models/full_form.dart';
import '../../../models/opened_form.dart';
import '../../../models/question.dart';
import '../../../models/sub_form.dart';
import '../../pages.dart';
import '../../widgets/drawer.dart';
import '../../widgets/loading_dialog.dart';
import '../../widgets/question_tile.dart';
import '../../widgets/text_field.dart';

late String id;
SmartShedOpenedForm? data;
SmartShedForm? form;

bool isLoading = true;
bool isAnswersShown = false;
bool isSearchBoxOpen = false;
bool isShowDetails = false;
bool isDesktop = false;

final searchController = TextEditingController();
late BuildContext context;
late void Function(void Function()) changeState;

// History
/*
{
  'qusID': [
    {
      'editedBy': 'Name',
      'editedAt': 'Date',
      'oldAns': 'Old Answer',
      'newAns': 'New Answer',
    },
    {
      'editedBy': 'Name',
      'editedAt': 'Date',
      'oldAns': 'Old Answer',
      'newAns': 'New Answer',
    },
  ],
}
*/
final Map<String, List<Map<String, dynamic>>> qusIdToHistory = {};

void initForm() async {
  form = await FormOpeningController.getForm(id);
  fillHistory();
  changeState(() => isLoading = false);
}

void fillHistory() {
  qusIdToHistory.clear();

  for (var question in form!.questions) {
    question.history = [];
  }

  /*
  form.history = [
      {
          "editedBy": "Name"
          "editedAt": "2023-12-14T15:28:37.335Z",
          "changes": [
              {
                  "questionID": "657b1ed1f9f54037c11efb94",
                  "oldValue": "Old Answer",
                  "newValue": "New Answer"
              }
          ],
      }
  ],
  */

  for (var history in form!.history) {
    for (var change in history['changes']) {
      final qusId = change['questionID'];
      final oldAns = change['oldValue'];
      final newAns = change['newValue'];

      if (qusIdToHistory[qusId] == null) {
        qusIdToHistory[qusId] = [];
      }

      qusIdToHistory[qusId]!.add({
        'editedBy': history['editedBy'],
        'editedAt': history['editedAt'],
        'oldAns': oldAns,
        'newAns': newAns,
      });
    }
  }

  for (var question in form!.questions) {
    if (qusIdToHistory[question.id] == null) continue;

    question.history = qusIdToHistory[question.id]!;
  }

  for (var subForm in form!.subForms) {
    for (var question in subForm.questions) {
      if (qusIdToHistory[question.id] == null) continue;

      question.history = qusIdToHistory[question.id]!;
    }
  }
}

AppBar buildAppBar() {
  return AppBar(
    title: Text(
      form!.title,
      style: const TextStyle(fontWeight: FontWeight.bold),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      textAlign: TextAlign.center,
    ),
    centerTitle: true,
    actions: const [
      IconButton(
        onPressed: saveForm,
        icon: Icon(Icons.save),
      ),
    ],
    automaticallyImplyLeading: !isDesktop,
  );
}

Widget buildLoading() {
  bool isData = data != null;

  return Scaffold(
    appBar: AppBar(
      title: isData
          ? Text(
              data!.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            )
          : const CircularProgressIndicator(
              color: Colors.white,
            ),
      automaticallyImplyLeading: !isDesktop,
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.save))],
    ),
    drawer: isDesktop ? null : const MyDrawer(),
    body: Row(
      children: [
        if (isDesktop) const MyDrawer(),
        Expanded(
          child: isData
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 20 : 5,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      buildTopInfoBar(fromForm: false),
                      const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ],
    ),
  );
}

Widget buildMainBody() {
  return Column(
    children: [
      buildTopInfoBar(),
      buildTopButtons(),
      if (isSearchBoxOpen) buildSearchBox(),
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
      buildTopButtons(isBottom: true),
      const SizedBox(height: 40),
    ],
  );
}

Widget buildTopInfoBar({bool fromForm = true}) {
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
      child: Column(
        children: [
          buildTopInfoDateAndNameRow(fromForm: fromForm),
          const SizedBox(height: 10),
          buildTopInfoDetails(fromForm: fromForm),
        ],
      ),
    ),
  );
}

Widget buildTopInfoDateAndNameRow({bool fromForm = true}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
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
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 50 : 8,
          vertical: 8,
        ),
        child: Column(
          children: [
            Text(
              "Created Date",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              fromForm ? form!.createdAtDateString : data!.createdAtDateString,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      Container(
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
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 50 : 8,
          vertical: 8,
        ),
        child: Column(
          children: [
            Text(
              "Loco Name & Number",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              fromForm
                  ? "${form!.locoName} ${form!.locoNumber}"
                  : "${data!.locoName} ${data!.locoNumber}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildTopInfoDetails({bool fromForm = true}) {
  return Container(
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
        TextButton(
          onPressed: () {
            changeState(() => isShowDetails = !isShowDetails);
          },
          style: TextButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            visualDensity: VisualDensity.compact,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isShowDetails ? "Hide Details" : "Show Details",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(width: 5),
              Icon(
                isShowDetails
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.grey.shade700,
                size: 12,
              ),
            ],
          ),
        ),
        if (isShowDetails)
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
                  fromForm
                      ? form!.descriptionEnglish
                      : data!.descriptionEnglish,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  fromForm ? form!.descriptionHindi : data!.descriptionHindi,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  "Created By",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  fromForm ? form!.createdBy : data!.createdBy,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Created At",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  fromForm ? form!.createdAtString : data!.createdAtString,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Updated At",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  fromForm ? form!.updatedAtString : data!.updatedAtString,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _buildButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.all(2),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

Widget buildTopButtons({bool isBottom = false}) {
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
      child: Column(
        children: [
          if (!isBottom)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                  text: "Search Question",
                  onPressed: () {
                    changeState(() => isSearchBoxOpen = !isSearchBoxOpen);
                  },
                ),
                _buildButton(
                  text: isAnswersShown ? "Hide Answers" : "Show Answers",
                  onPressed: () {
                    for (var question in form!.questions) {
                      question.isExpanded = !isAnswersShown;
                    }

                    for (var subForm in form!.subForms) {
                      for (var question in subForm.questions) {
                        question.isExpanded = !isAnswersShown;
                      }
                    }

                    changeState(() => isAnswersShown = !isAnswersShown);
                  },
                ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton(
                text: "Save Form",
                onPressed: saveForm,
              ),
              _buildButton(
                text: "Submit Form",
                onPressed: submitForm,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget buildSearchBox() {
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
        child: MyTextField(
          hintText: "Search Question",
          controller: searchController,
          suffixIcon: IconButton(
            onPressed: () {
              changeState(() => isSearchBoxOpen = false);
            },
            icon: const Icon(Icons.close),
          ),
          onChanged: (value) {
            changeState(() {});
          },
        )),
  );
}

Widget buildQuestionsContainer(
  List<SmartShedQuestion> questions,
  SmartShedSubForm? subForm,
) {
  if (questions.isEmpty) return const SizedBox();

  if (isSearchBoxOpen) {
    questions = questions.where((question) {
      return question.textEnglish
              .toLowerCase()
              .contains(searchController.text.toLowerCase()) ||
          question.textHindi
              .toLowerCase()
              .contains(searchController.text.toLowerCase());
    }).toList();
  }

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
              child: QuestionTile(
                qKey: ValueKey<String>(
                  "${isAnswersShown ? "hidden" : "shown"}${searchController.text}",
                ),
                question: question,
                questionNumber: questions.indexOf(question) + 1,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void saveForm() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const LoadingDialog(
      title: "Saving Form...",
    ),
  );

  await FormAnsweringController.saveForm(form!);

  if (!context.mounted) return;
  GoRouter.of(context).pop();
}

void submitForm() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const LoadingDialog(
      title: "Submitting Form...",
    ),
  );

  await FormAnsweringController.submitForm(form!);

  if (!context.mounted) return;
  GoRouter.of(context).pop();
  GoRouter.of(context).go(Pages.dashboard);
}
