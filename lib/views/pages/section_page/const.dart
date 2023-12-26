import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../controllers/dashboard/for_all.dart';
import '../../../controllers/dashboard/for_me.dart';
import '../../../controllers/toast/toast.dart';
import '../../../models/opened_form.dart';
import '../../../models/unopened_form.dart';
import '../../localization/section.dart';
import '../../localization/toast.dart';
import '../../widgets/form_tile.dart';
import '../../widgets/opened_form_tile.dart';

Map<String, List<SmartShedUnopenedForm>> formsForAllSections = {};
Map<String, List<SmartShedOpenedForm>> recentlyOpenedFormsForAllSections = {};
Map<String, List<SmartShedOpenedForm>> allOpenedFormsForAllSections = {};

late String title;

late List<SmartShedUnopenedForm> formsForSection;
late List<SmartShedOpenedForm> recentlyOpenedFormsForSection;
late List<SmartShedOpenedForm> allOpenedFormsForSection;

late bool isFormsForSectionLoading;
late bool isRecentlyOpenedFormsLoading;
late bool isAllOpenedFormsLoading;

late BuildContext context;
late void Function(void Function()) changeState;

void initConst(
  String sectionTitle,
  void Function(void Function()) setState,
) {
  title = sectionTitle;
  changeState = setState;

  isFormsForSectionLoading = true;
  isRecentlyOpenedFormsLoading = true;
  isAllOpenedFormsLoading = true;

  if (formsForAllSections[title] == null) {
    formsForAllSections[title] = [];
  }

  if (recentlyOpenedFormsForAllSections[title] == null) {
    recentlyOpenedFormsForAllSections[title] = [];
  }

  if (allOpenedFormsForAllSections[title] == null) {
    allOpenedFormsForAllSections[title] = [];
  }

  formsForSection = formsForAllSections[title]!;
  recentlyOpenedFormsForSection = recentlyOpenedFormsForAllSections[title]!;
  allOpenedFormsForSection = allOpenedFormsForAllSections[title]!;

  init();
}

void init() {
  DashboardForAllController.init();
  DashboardForMeController.init();

  initFormsForSection();
  initRecentlyOpenedForms();
  initAllOpenedForms();
}

Future<void> initFormsForSection() async {
  List<SmartShedUnopenedForm>? forms =
      await DashboardForAllController.getFormsForSection(title);

  if (forms == null) {
    if (!context.mounted) return;
    ToastController.error(
      Toast_LocaleData.error_while_fetching_forms.getString(context),
    );
    changeState(() => isFormsForSectionLoading = false);
    return;
  }

  if (forms.isEmpty) {
    if (!context.mounted) return;
    ToastController.error(
      Toast_LocaleData.no_form_found_for_section.getString(context),
    );
  }

  formsForSection = forms;
  changeState(() => isFormsForSectionLoading = false);
}

Future<void> initRecentlyOpenedForms() async {
  List<SmartShedOpenedForm>? recentlyOpenedForms =
      await DashboardForMeController.getRecentlyOpenedFormsForSection(title);

  if (recentlyOpenedForms == null) {
    if (!context.mounted) return;
    ToastController.error(
      Toast_LocaleData.error_while_fetching_recently_opened_forms_for_section
          .getString(context),
    );
    changeState(() => isRecentlyOpenedFormsLoading = false);
    return;
  }

  if (recentlyOpenedForms.isEmpty) {
    if (!context.mounted) return;
    ToastController.error(
      Toast_LocaleData.no_recently_opened_form_found_for_section
          .getString(context),
    );
  }

  recentlyOpenedFormsForSection = recentlyOpenedForms;
  changeState(() => isRecentlyOpenedFormsLoading = false);
}

Future<void> initAllOpenedForms() async {
  List<SmartShedOpenedForm>? openedForms =
      await DashboardForAllController.getOpenedFormsForSection(title);

  if (openedForms == null) {
    if (!context.mounted) return;
    ToastController.error(
      Toast_LocaleData.error_while_fetching_opened_forms.getString(context),
    );
    changeState(() => isAllOpenedFormsLoading = false);
    return;
  }

  if (openedForms.isEmpty) {
    if (!context.mounted) return;
    ToastController.error(
      Toast_LocaleData.no_opened_form_found_for_section.getString(context),
    );
  }

  allOpenedFormsForSection = openedForms;
  changeState(() => isAllOpenedFormsLoading = false);
}

AppBar buildAppBar() {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
  );
}

Widget buildFormsList() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        !isFormsForSectionLoading && formsForSection.isEmpty
            ? Section_LocaleData.no_forms_found.getString(context)
            : context.formatString(
                Section_LocaleData.forms_for_section.getString(context),
                [title],
              ),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 20),
      isFormsForSectionLoading
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
              itemCount: formsForSection.length,
              itemBuilder: (context, index) {
                return FormTile(
                  index: index,
                  form: formsForSection[index],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
            ),
    ],
  );
}

Widget buildRecentlyOpenedFormsList() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 20),
      Text(
        !isRecentlyOpenedFormsLoading && recentlyOpenedFormsForSection.isEmpty
            ? Section_LocaleData.no_recently_opened_forms_found
                .getString(context)
            : Section_LocaleData.recently_opened_forms.getString(context),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 20),
      isRecentlyOpenedFormsLoading
          ? ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return const OpenedFormTileShimmer();
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
            )
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentlyOpenedFormsForSection.length,
              itemBuilder: (context, index) {
                return OpenedFormTile(
                  index: index,
                  openedForm: recentlyOpenedFormsForSection[index],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
            ),
    ],
  );
}

Widget buildAllOpenedFormsList() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 20),
      Text(
        !isAllOpenedFormsLoading && allOpenedFormsForSection.isEmpty
            ? Section_LocaleData.no_opened_forms_found.getString(context)
            : Section_LocaleData.opened_forms.getString(context),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 20),
      isAllOpenedFormsLoading
          ? ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return const OpenedFormTileShimmer();
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
            )
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: allOpenedFormsForSection.length,
              itemBuilder: (context, index) {
                return OpenedFormTile(
                  index: index,
                  openedForm: allOpenedFormsForSection[index],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
            ),
    ],
  );
}

Widget buildMainBody() {
  return Column(
    children: [
      buildFormsList(),
      const SizedBox(height: 20),
      buildRecentlyOpenedFormsList(),
      const SizedBox(height: 20),
      buildAllOpenedFormsList(),
    ],
  );
}
