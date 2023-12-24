import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/auth/login.dart';
import '../../../controllers/dashboard/for_all.dart';
import '../../../controllers/forms/answering.dart';
import '../../../controllers/forms/approving.dart';
import '../../../controllers/forms/opening.dart';
import '../../../models/full_form.dart';
import '../../../models/opened_form.dart';
import '../../../models/question.dart';
import '../../../models/section.dart';
import '../../../models/sub_form.dart';
import '../../pages.dart';
import '../../widgets/drawer.dart';
import '../../widgets/dropdown.dart';
import '../../widgets/loading_dialog.dart';
import '../../widgets/question_tile.dart';
import '../../widgets/text_field.dart';
import 'print.dart';

late String id;
late SmartShedOpenedForm? data;
late SmartShedForm? form;

late List<String> sections;

late bool isLoading;
late bool isSectionLoading;
late bool isAnswersShown;
late bool isSearchBoxOpen;
late bool isEmployeeNameFilter;
late bool isEmployeeSectionFilter;
late bool isShowDetails;
late bool isDesktop;

late TextEditingController searchController;
late TextEditingController employeeNameController;
late TextEditingController employeeSectionController;

late ScrollController scrollController;
late AnimationController animationController;
late bool isScrollToTopVisible;

late BuildContext context;
late dynamic state;
late void Function(void Function()) changeState;

final Map<String, List<SmartShedQuestionHistory>> qusIdToHistory = {};

void initConst(
  String formId,
  SmartShedOpenedForm? formData,
  void Function(void Function()) setState,
  bool isUserDesktop,
  dynamic stateThis,
) {
  id = formId;
  data = formData;
  changeState = setState;
  isDesktop = isUserDesktop;
  state = stateThis;

  sections = [];

  isLoading = true;
  isSectionLoading = true;
  isAnswersShown = false;
  isSearchBoxOpen = false;
  isEmployeeNameFilter = false;
  isEmployeeSectionFilter = false;
  isShowDetails = false;

  searchController = TextEditingController();
  employeeNameController = TextEditingController();
  employeeSectionController = TextEditingController();

  scrollController = ScrollController();
  animationController = AnimationController(
    vsync: state as TickerProvider,
    duration: const Duration(milliseconds: 500),
  );
  isScrollToTopVisible = false;

  initForm();
  initSections();

  addScrollListener();
}

void initForm() async {
  form = await FormOpeningController.getForm(id);
  fillHistory();
  changeState(() => isLoading = false);
}

void initSections() async {
  final List<SmartShedSection> sectionsList =
      await DashboardForAllController.getSections();

  sections = sectionsList.map((e) => e.title).toList();
  changeState(() => isSectionLoading = false);
}

void fillHistory() {
  qusIdToHistory.clear();

  for (var question in form!.questions) {
    question.history = [];
  }

  for (var history in form!.history) {
    for (var change in history['changes']) {
      final qusId = change['questionID'];
      final oldValue = change['oldValue'];
      final newValue = change['newValue'];

      if (qusIdToHistory[qusId] == null) {
        qusIdToHistory[qusId] = [];
      }

      qusIdToHistory[qusId]!.add(
        SmartShedQuestionHistory(
          editedBy: history['editedBy'],
          editedAt: history['editedAt'],
          section: history['section'],
          oldValue: oldValue,
          newValue: newValue,
        ),
      );
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
    actions: [
      const IconButton(
        onPressed: saveForm,
        icon: Icon(Icons.save),
      ),
      IconButton(
        onPressed: () => printForm(form!),
        icon: const Icon(Icons.print),
      ),
    ],
    automaticallyImplyLeading: !isDesktop,
  );
}

Widget? buildFloatingActionButton() {
  if (!isScrollToTopVisible) return null;

  return ScaleTransition(
    scale: CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ),
    child: FloatingActionButton(
      onPressed: () {
        animationController.reverse();
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
      },
      mini: true,
      tooltip: "Scroll to Top",
      child: const Icon(Icons.arrow_upward),
    ),
  );
}

void addScrollListener() {
  scrollController.addListener(() {
    if (scrollController.position.pixels > 600 && !isScrollToTopVisible) {
      animationController.forward();
      changeState(() => isScrollToTopVisible = true);
    } else if (scrollController.offset < 600 && isScrollToTopVisible) {
      animationController.reverse();
      changeState(() => isScrollToTopVisible = false);
    }
  });
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
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.save)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.print)),
      ],
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
      buildButtons(),
      if (isSearchBoxOpen) buildSearchBox(),
      if (isEmployeeNameFilter) buildEmployeeNameFilter(),
      if (isEmployeeSectionFilter) buildEmployeeSectionFilter(),
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
      buildButtons(isBottom: true),
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
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}

Widget buildButtons({bool isBottom = false}) {
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
          if (!isBottom) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                  text: "Search Question",
                  onPressed: () {
                    changeState(() => isSearchBoxOpen = !isSearchBoxOpen);
                    if (!isSearchBoxOpen) searchController.clear();
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
                  text: "Filter by Name",
                  onPressed: () {
                    changeState(
                        () => isEmployeeNameFilter = !isEmployeeNameFilter);
                    if (!isEmployeeNameFilter) employeeNameController.clear();
                  },
                ),
                _buildButton(
                  text: "Filter by Section",
                  onPressed: () {
                    changeState(() =>
                        isEmployeeSectionFilter = !isEmployeeSectionFilter);
                    if (!isEmployeeSectionFilter) {
                      employeeSectionController.clear();
                    }
                  },
                ),
              ],
            ),
          ],
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
          if (form!.submittedCount > 0 && !LoginController.isWorker)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                  text: "Approve Form",
                  onPressed: approveForm,
                ),
                _buildButton(
                  text: "Reject Form",
                  onPressed: rejectForm,
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
            searchController.clear();
          },
          icon: const Icon(Icons.close),
        ),
        onChanged: (value) {
          changeState(() {});
        },
        keyboardType: TextInputType.text,
      ),
    ),
  );
}

Widget buildEmployeeNameFilter() {
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
        hintText: "Employee Name",
        controller: employeeNameController,
        suffixIcon: IconButton(
          onPressed: () {
            changeState(() => isEmployeeNameFilter = false);
            employeeNameController.clear();
          },
          icon: const Icon(Icons.close),
        ),
        onChanged: (value) {
          changeState(() {});
        },
        keyboardType: TextInputType.text,
      ),
    ),
  );
}

Widget buildEmployeeSectionFilter() {
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
      child: Row(
        children: [
          const SizedBox(width: 5),
          Expanded(
            child: MyDropdown(
              hintText: 'Employee Section',
              controller: employeeSectionController,
              items: sections,
              onChanged: () => changeState(() {}),
            ),
          ),
          const SizedBox(width: 5),
          IconButton(
            onPressed: () {
              changeState(() => isEmployeeSectionFilter = false);
              employeeSectionController.clear();
            },
            icon: const Icon(Icons.close),
            iconSize: 18,
          ),
        ],
      ),
    ),
  );
}

List<SmartShedQuestion> getFilteredQuestions(
    List<SmartShedQuestion> questions) {
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

  if (isEmployeeNameFilter) {
    questions = questions.where((question) {
      return question.history.any((history) {
        return history.editedBy
            .toLowerCase()
            .contains(employeeNameController.text.toLowerCase());
      });
    }).toList();
  }

  if (isEmployeeSectionFilter) {
    questions = questions.where((question) {
      return question.history.any((history) {
        if (history.section == null) return false;

        return history.section!
            .toLowerCase()
            .contains(employeeSectionController.text.toLowerCase());
      });
    }).toList();
  }

  return questions;
}

Widget buildQuestionsContainer(
  List<SmartShedQuestion> questions,
  SmartShedSubForm? subForm,
) {
  if (questions.isEmpty) return const SizedBox();
  List<SmartShedQuestion> filteredQuestions = getFilteredQuestions(questions);
  if (filteredQuestions.isEmpty) return const SizedBox();

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
          ...filteredQuestions.map(
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

void approveForm() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const LoadingDialog(
      title: "Approving Form...",
    ),
  );

  await FormApprovingController.approveForm(id);

  if (!context.mounted) return;
  GoRouter.of(context).pop();
  GoRouter.of(context).go(Pages.dashboard);
}

void rejectForm() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const LoadingDialog(
      title: "Rejecting Form...",
    ),
  );

  await FormApprovingController.rejectForm(id);

  if (!context.mounted) return;
  GoRouter.of(context).pop();
  GoRouter.of(context).go(Pages.dashboard);
}

void disposeConst() {
  searchController.dispose();
  employeeNameController.dispose();
  employeeSectionController.dispose();

  scrollController.dispose();
  animationController.dispose();
}
