import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/dashboard/for_all.dart';
import '../../../controllers/toast/toast.dart';
import '../../../models/section.dart';
import '../../../models/unopened_form.dart';
import '../../localization/manage_forms.dart';
import '../../localization/toast.dart';
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
  final List<SmartShedSection>? sectionsList =
      await DashboardForAllController.getSections();

  if (sectionsList == null) {
    if (!context.mounted) return;
    ToastController.error(
      Toast_LocaleData.error_while_fetching_sections.getString(context),
    );
    changeState(() => isLoadingSections = false);
    return;
  }

  if (sectionsList.isEmpty) {
    if (!context.mounted) return;
    ToastController.error(
      Toast_LocaleData.no_section_found.getString(context),
    );
  }

  sections =
      sectionsList.map((SmartShedSection section) => section.title).toList();
  changeState(() => isLoadingSections = false);
}

void initForms() async {
  if (sectionController.text.isEmpty) return;
  changeState(() => isLoadingForms = true);

  List<SmartShedUnopenedForm>? formsList =
      await DashboardForAllController.getFormsForSection(
          sectionController.text);

  if (formsList == null) {
    if (!context.mounted) return;
    ToastController.error(
      Toast_LocaleData.error_while_fetching_unopened_form.getString(context),
    );
    changeState(() => isLoadingForms = false);
    return;
  }

  if (formsList.isEmpty) {
    if (!context.mounted) return;
    ToastController.error(
      Toast_LocaleData.no_unopened_form_found.getString(context),
    );
  }

  forms = formsList;
  changeState(() => isLoadingForms = false);
}

void disposeConst() {
  sectionController.dispose();
}

AppBar buildAppBar() {
  return AppBar(
    title: Text(
      ManageForms_LocaleData.title.getString(context),
      style: const TextStyle(
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
      Text(
        ManageForms_LocaleData.create_section.getString(context),
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
              ManageForms_LocaleData.new_section_button_message
                  .getString(context),
              textAlign: TextAlign.center,
              style: const TextStyle(
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
              child: Text(
                ManageForms_LocaleData.add_section.getString(context),
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
      Text(
        ManageForms_LocaleData.choose_section_to_manage.getString(context),
        style: const TextStyle(
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
                hintText:
                    ManageForms_LocaleData.choose_section.getString(context),
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
          ManageForms_LocaleData.choose_section_message.getString(context),
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
              context.formatString(
                ManageForms_LocaleData.create_new_form_in_section
                    .getString(context),
                [sectionController.text],
              ),
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
                    context.formatString(
                      ManageForms_LocaleData.new_form_button_message
                          .getString(context),
                      [sectionController.text],
                    ),
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
                      context.formatString(
                        ManageForms_LocaleData.add_form_in_section
                            .getString(context),
                        [sectionController.text],
                      ),
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
            Text(
              ManageForms_LocaleData.choose_form_to_manage.getString(context),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !isLoadingForms && forms.isEmpty
                    ? Text(
                        ManageForms_LocaleData.no_forms_found
                            .getString(context),
                        style: const TextStyle(
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
