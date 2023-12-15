import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/dashboard/for_all.dart';
import '../../../controllers/dashboard/for_me.dart';
import '../../../models/opened_form.dart';
import '../../../models/section.dart';
import '../../pages.dart';
import '../../widgets/opened_form_tile.dart';
import '../../widgets/section_tile.dart';

List<SmartShedSection> sections = [];
List<SmartShedOpenedForm> recentlyOpenedForms = [];
bool isSectionLoading = true;
bool isRecentlyOpenedFormsLoading = true;

late BuildContext context;
late void Function(void Function()) changeState;

void init() {
  DashboardForAllController.init();
  DashboardForMeController.init();

  _initSections();
  _initRecentlyOpenedForms();
}

Future<void> _initSections() async {
  sections = await DashboardForAllController.getSections();

  changeState(() {
    isSectionLoading = false;
  });
}

Future<void> _initRecentlyOpenedForms() async {
  recentlyOpenedForms = await DashboardForMeController.getRecentlyOpenedForms();

  changeState(() {
    isRecentlyOpenedFormsLoading = false;
  });
}

AppBar buildAppBar() {
  return AppBar(
    title: const Text(
      'DASHBOARD',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: () {
          GoRouter.of(context).push(Pages.notifications);
        },
        icon: const Icon(Icons.notifications),
      ),
    ],
  );
}

Widget buildSectionsList() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        !isSectionLoading && sections.isEmpty
            ? 'No Sections Found'
            : 'Sections',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 20),
      isSectionLoading
          ? ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return const SectionTileShimmer();
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
            )
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sections.length,
              itemBuilder: (context, index) {
                return SectionTile(
                  index: index,
                  section: sections[index],
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
      Text(
        !isRecentlyOpenedFormsLoading && recentlyOpenedForms.isEmpty
            ? 'No Recently Opened Forms'
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
              itemCount: recentlyOpenedForms.length,
              itemBuilder: (context, index) {
                return OpenedFormTile(
                  index: index,
                  openedForm: recentlyOpenedForms[index],
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
      buildSectionsList(),
      const SizedBox(height: 30),
      buildRecentlyOpenedFormsList(),
    ],
  );
}
