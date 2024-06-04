import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/dashboard/for_all.dart';
import '../../../controllers/dashboard/for_me.dart';
import '../../../controllers/dashboard/notifications.dart';
import '../../../controllers/toast/toast.dart';
import '../../../models/opened_form.dart';
import '../../../models/section.dart';
import '../../localization/dashboard.dart';
import '../../localization/toast.dart';
import '../../pages.dart';
import '../../widgets/notification_icon.dart';
import '../../widgets/opened_form_tile.dart';
import '../../widgets/section_tile.dart';

List<SmartShedSection> sections = [];
List<SmartShedOpenedForm> recentlyOpenedForms = [];
bool isSectionLoading = true;
bool isRecentlyOpenedFormsLoading = true;

late BuildContext context;
late void Function(void Function()) changeState;

NotificationsController notificationsController = NotificationsController();

void initConst() {
  DashboardForAllController.init();
  DashboardForMeController.init();
  notificationsController.fetchNotifications(
    onDone: () => changeState(() {}),
  );

  changeState(() {});

  _initSections();
  _initRecentlyOpenedForms();
}

Future<void> _initSections() async {
  List<SmartShedSection>? sectionsList =
      await DashboardForAllController.getSections();

  if (sectionsList == null) {
    if (!context.mounted) return;
    ToastController.error(
      Toast_LocaleData.error_while_fetching_sections.getString(context),
    );
    changeState(() => isSectionLoading = false);
    return;
  }

  if (sectionsList.isEmpty) {
    if (!context.mounted) return;
    ToastController.error(
      Toast_LocaleData.no_section_found.getString(context),
    );
  }

  sections = sectionsList;
  changeState(() => isSectionLoading = false);
}

Future<void> _initRecentlyOpenedForms() async {
  List<SmartShedOpenedForm>? recentlyForms =
      await DashboardForMeController.getRecentlyOpenedForms();

  if (recentlyForms == null) {
    if (!context.mounted) return;
    ToastController.error(
      Toast_LocaleData.error_while_fetching_recently_opened_forms
          .getString(context),
    );
    changeState(() => isRecentlyOpenedFormsLoading = false);
    return;
  }

  if (recentlyForms.isEmpty) {
    if (!context.mounted) return;
    ToastController.error(
      Toast_LocaleData.no_recently_opened_form_found.getString(context),
    );
  }

  recentlyOpenedForms = recentlyForms;
  changeState(() {
    isRecentlyOpenedFormsLoading = false;
  });
}

AppBar buildAppBar() {
  return AppBar(
    title: Text(
      Dashboard_LocaleData.title.getString(context),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    centerTitle: true,
    actions: [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          GoRouter.of(context).push(Pages.search);
        },
      ),
      NotificationIcon(
        key: ValueKey<int>(notificationsController.unreadNotificationsCount),
        iconData: Icons.notifications,
        onTap: () {
          GoRouter.of(context)
              .push(Pages.notifications)
              .then((value) => notificationsController.fetchNotifications(
                    onDone: () => changeState(() {}),
                  ));
        },
        notificationCount: notificationsController.unreadNotificationsCount,
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
            ? Dashboard_LocaleData.no_section_found.getString(context)
            : Dashboard_LocaleData.sections.getString(context),
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
            ? Dashboard_LocaleData.no_recently_opened_form_found
                .getString(context)
            : Dashboard_LocaleData.recently_opened_forms.getString(context),
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
