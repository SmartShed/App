import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:smartshed/views/localization/toast.dart';

import '../../../../controllers/smartshed/smartshed.dart';
import '../../../../controllers/toast/toast.dart';
import '../../../localization/manage_create_section.dart';
import '../../../widgets/loading_dialog.dart';
import '../../../widgets/text_field.dart';

late BuildContext context;
TextEditingController sectionNameController = TextEditingController();

void initConst(BuildContext ctx) {
  context = ctx;
  sectionNameController.clear();
}

AppBar buildAppBar() {
  return AppBar(
    title: Text(
      Manage_CreateSection_LocaleData.title.getString(context),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    centerTitle: true,
  );
}

Widget buildBody() {
  return Column(
    children: [
      const SizedBox(height: 20),
      Text(
        Manage_CreateSection_LocaleData.create_section.getString(context),
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 20),
      Text(
        Manage_CreateSection_LocaleData.enter_section_name.getString(context),
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 40),
      MyTextField(
        hintText:
            Manage_CreateSection_LocaleData.section_name.getString(context),
        controller: sectionNameController,
        isTextCentered: true,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.characters,
      ),
      const SizedBox(height: 40),
      ElevatedButton(
        onPressed: createSection,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 12,
          ),
        ),
        child: Text(
          Manage_CreateSection_LocaleData.create_section_button
              .getString(context),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    ],
  );
}

void createSection() async {
  if (sectionNameController.text.isEmpty) {
    ToastController.error(
        Toast_LocaleData.enter_section_name.getString(context));
    return;
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => LoadingDialog(
      title:
          Manage_CreateSection_LocaleData.creating_section.getString(context),
    ),
  );

  bool isSectionCreated =
      await SmartShedController.addSection(sectionNameController.text);

  if (!context.mounted) return;
  GoRouter.of(context).pop();

  if (isSectionCreated) {
    ToastController.success(
        Toast_LocaleData.section_added_successfully.getString(context));
    if (!context.mounted) return;
    GoRouter.of(context).pop();
  } else {
    ToastController.error(
        Toast_LocaleData.error_adding_section.getString(context));
  }
}
