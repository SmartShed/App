import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/dashboard/for_all.dart';
import '../../../models/section.dart';
import '../../../models/unopened_form.dart';
import '../../pages.dart';
import '../../widgets/dropdown.dart';
import '../../widgets/form_tile.dart';

late TextEditingController sectionController;

late List<String> sections;
late bool isLoadingSections;

late List<SmartShedUnopenedForm> forms;
late bool isLoadingForms;

late BuildContext context;
late void Function(void Function()) changeState;

void initConst(void Function(void Function()) setState) {
  changeState = setState;

  sectionController = TextEditingController();

  initSections();
}

void initSections() async {
  changeState(() => isLoadingSections = true);
  final List<SmartShedSection> sectionsList =
      await DashboardForAllController.getSections();
  sections =
      sectionsList.map((SmartShedSection section) => section.title).toList();
  changeState(() => isLoadingSections = false);
}

void initForms() async {
  if (sectionController.text.isEmpty) return;

  changeState(() => isLoadingForms = true);
  forms = await DashboardForAllController.getFormsForSection(
      sectionController.text);
  changeState(() => isLoadingForms = false);
}

void disposeConst() {
  sectionController.dispose();
}

AppBar buildAppBar() {
  return AppBar(
    title: const Text(
      'MANAGE FORMS',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    centerTitle: true,
  );
}

Widget buildBody() {
  return SizedBox(
    width: double.infinity,
    height: sectionController.text.isEmpty
        ? MediaQuery.of(context).size.height
        : null,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        buildSectionBody(),
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 20),
        buildFormBody(),
        const SizedBox(height: 40),
      ],
    ),
  );
}

Widget buildSectionBody() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Create new section',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white60,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            const Text(
              'If you want to add new section, please click the button below.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                GoRouter.of(context).push(Pages.manageCreateSection);
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                side: const BorderSide(color: Colors.grey),
              ),
              child: const Text(
                'Add new section',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  // color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      const Divider(),
      const SizedBox(height: 20),
      const Text(
        'Choose section to manage',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 10),
      isLoadingSections
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MyDropdown(
                hintText: 'Choose section',
                controller: sectionController,
                items: sections,
                onChanged: () => initForms(),
              ),
            ),
      const SizedBox(height: 10),
    ],
  );
}

Widget buildFormBody() {
  return sectionController.text.isEmpty
      ? Text(
          'Choose section to manage forms of that section',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.2),
          ),
        )
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create new form in ${sectionController.text}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white60,
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Text(
                    'If you want to add new form in ${sectionController.text}, please click the button below.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      GoRouter.of(context).push(
                          "${Pages.manageCreateForm}/${sectionController.text}");
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: Text(
                      'Add new form in ${sectionController.text}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Choose form to manage',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !isLoadingForms && forms.isEmpty
                    ? const Text(
                        'No Forms Found',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 20),
                isLoadingForms
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return const FormTileShimmer();
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 12);
                        },
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: forms.length,
                        itemBuilder: (context, index) {
                          return FormTile(
                            index: index,
                            form: forms[index],
                            onTapRoute: Pages.manageManageForm,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 12);
                        },
                      ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        );
}
