import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:smartshed/views/localization/toast.dart';

import '../../../../controllers/smartshed/smartshed.dart';
import '../../../../controllers/toast/toast.dart';
import '../../../localization/manage_create_form.dart';
import '../../../widgets/loading_dialog.dart';
import '../../../widgets/text_field.dart';

late BuildContext context;
late String sectionTitle;

TextEditingController formTitleController = TextEditingController();
TextEditingController descriptionEnglishController = TextEditingController();
TextEditingController descriptionHindiController = TextEditingController();

void initConst(BuildContext ctx, String formSectionTitle) {
  context = ctx;
  sectionTitle = formSectionTitle;

  formTitleController.clear();
  descriptionEnglishController.clear();
  descriptionHindiController.clear();
}

AppBar buildAppBar() {
  return AppBar(
    title: Text(
      Manage_CreateForm_LocaleData.title.getString(context),
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
        context.formatString(
          Manage_CreateForm_LocaleData.create_form_for_section,
          [sectionTitle],
        ),
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 20),
      Text(
        Manage_CreateForm_LocaleData.enter_form_details.getString(context),
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 40),
      MyTextField(
        hintText: Manage_CreateForm_LocaleData.form_title.getString(context),
        controller: formTitleController,
        isTextCentered: true,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
      ),
      const SizedBox(height: 20),
      MyTextField(
        hintText:
            Manage_CreateForm_LocaleData.english_description.getString(context),
        controller: descriptionEnglishController,
        isTextCentered: true,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
      ),
      const SizedBox(height: 20),
      MyTextField(
        hintText:
            Manage_CreateForm_LocaleData.hindi_description.getString(context),
        controller: descriptionHindiController,
        isTextCentered: true,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
      ),
      const SizedBox(height: 40),
      ElevatedButton(
        onPressed: createForm,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 12,
          ),
        ),
        child: Text(
          Manage_CreateForm_LocaleData.create_form.getString(context),
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

void createForm() async {
  if (formTitleController.text.isEmpty ||
      descriptionEnglishController.text.isEmpty ||
      descriptionHindiController.text.isEmpty) {
    ToastController.error(Toast_LocaleData.enter_all_fields.getString(context));
    return;
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => LoadingDialog(
      title: Manage_CreateForm_LocaleData.creating_form.getString(context),
    ),
  );

  bool isFormCreated = await SmartShedController.addForm(
    sectionTitle,
    formTitleController.text,
    descriptionEnglishController.text,
    descriptionHindiController.text,
  );

  if (!context.mounted) return;
  GoRouter.of(context).pop();

  if (isFormCreated) {
    ToastController.success(
        Toast_LocaleData.form_added_successfully.getString(context));
    if (!context.mounted) return;
    GoRouter.of(context).pop();
  } else {
    ToastController.error(
        Toast_LocaleData.error_adding_form.getString(context));
  }
}
