import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/smartshed/faqs.dart';
import '../../../controllers/toast/toast.dart';
import '../../../models/faq.dart';
import '../../localization/settings.dart';
import '../../pages.dart';
import '../../widgets/app_info.dart';

late BuildContext context;
late void Function(void Function()) changeState;

List<SmartShedFAQ> faqs = [];
bool isFaqsLoading = true;

void initConst(void Function(void Function()) setState) {
  changeState = setState;
  faqs = [];
  isFaqsLoading = true;

  _initFaqs();
}

void disposeConst() {
  faqs = [];
  isFaqsLoading = true;
}

Future<void> _initFaqs() async {
  changeState(() => isFaqsLoading = true);

  List<SmartShedFAQ>? faqsList = await FaqHandler.getFaqs();

  if (faqsList == null) {
    if (!context.mounted) return;
    ToastController.error(
        Settings_LocaleData.error_getting_faqs.getString(context));
    changeState(() => isFaqsLoading = false);
    return;
  }

  faqs = faqsList;
  changeState(() => isFaqsLoading = false);
}

AppBar buildAppBar() {
  return AppBar(
    title: Text(
      Settings_LocaleData.help_title.getString(context),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    centerTitle: true,
  );
}

Widget buildBody() {
  return isFaqsLoading
      ? const Center(child: CircularProgressIndicator())
      : Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              Settings_LocaleData.faqs.getString(context),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              textAlign: TextAlign.left,
            ),
            for (final faq in faqs) buildFAQ(faq),
            const SizedBox(height: 20),
            buildUserManualButton(),
            const SizedBox(height: 20),
            const AppInfo(),
            const SizedBox(height: 40),
          ],
        );
}

Widget buildFAQ(SmartShedFAQ faq) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.symmetric(
      vertical: 5,
    ),
    child: ExpansionTile(
      shape: const Border(),
      backgroundColor: Colors.transparent,
      collapsedBackgroundColor: Colors.transparent,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            faq.questionEnglish!,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            faq.questionHindi!,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          child: Column(
            children: [
              Text(
                faq.answerEnglish!,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 5),
              Text(
                faq.answerHindi!,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildUserManualButton() {
  return ElevatedButton(
    onPressed: () {
      GoRouter.of(context).push(Pages.userManual);
    },
    child: Text(
      Settings_LocaleData.see_user_manual.getString(context),
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
