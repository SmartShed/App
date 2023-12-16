import 'package:flutter/material.dart';

import '../../../controllers/dashboard/for_all.dart';
import '../../../controllers/dashboard/for_me.dart';
import '../../../models/opened_form.dart';
import '../../../models/unopened_form.dart';
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
  formsForSection = await DashboardForAllController.getFormsForSection(title);
  changeState(() => isFormsForSectionLoading = false);
}

Future<void> initRecentlyOpenedForms() async {
  recentlyOpenedFormsForSection =
      await DashboardForMeController.getRecentlyOpenedFormsForSection(title);
  changeState(() => isRecentlyOpenedFormsLoading = false);
}

Future<void> initAllOpenedForms() async {
  allOpenedFormsForSection =
      await DashboardForAllController.getOpenedFormsForSection(title);
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
            ? 'No Forms Found'
            : 'Forms',
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
            ? 'No Recently Opened Forms Found'
            : 'Recently Opened Forms',
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
            ? 'No Opened Forms Found'
            : 'All Opened Forms',
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
