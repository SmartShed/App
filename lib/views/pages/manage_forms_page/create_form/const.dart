import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../controllers/smartshed/smartshed.dart';
import '../../../../controllers/toast/toast.dart';
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
    title: const Text(
      'CREATE FORM',
      style: TextStyle(
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
        'Create Form for $sectionTitle',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 20),
      Text(
        'Enter the details of the form you want to create.',
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 40),
      MyTextField(
        hintText: 'Form Title',
        controller: formTitleController,
        isTextCentered: true,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
      ),
      const SizedBox(height: 20),
      MyTextField(
        hintText: 'English Description (Optional)',
        controller: descriptionEnglishController,
        isTextCentered: true,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
      ),
      const SizedBox(height: 20),
      MyTextField(
        hintText: 'Hindi Description (Optional)',
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
        child: const Text(
          'Create Form',
          style: TextStyle(
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
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const LoadingDialog(
      title: "Creating Form...",
    ),
  );

  bool isFormCreated = await SmartShedController.createForm(
    sectionTitle,
    formTitleController.text,
    descriptionEnglishController.text,
    descriptionHindiController.text,
  );

  if (!context.mounted) return;
  GoRouter.of(context).pop();

  if (isFormCreated) {
    ToastController.success('Form created successfully');
    if (!context.mounted) return;
    GoRouter.of(context).pop();
  }
}
