import 'package:flutter/material.dart';

import '../../../models/opened_form.dart';
import '../../../models/section.dart';
import '../../widgets/opened_form_tile.dart';
import '../../widgets/section_tile.dart';

AppBar buildAppBar() {
  return AppBar(
    title: const Text(
      'DASHBOARD',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
  );
}

Widget buildSectionsList(
  bool isSectionLoading,
  List<SmartShedSection> sections,
) {
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

Widget buildRecentlyOpenedFormsList(
  bool isRecentlyOpenedFormsLoading,
  List<SmartShedOpenedForm> recentlyOpenedForms,
) {
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
