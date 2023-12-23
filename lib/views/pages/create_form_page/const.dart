import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/forms/opening.dart';
import '../../../models/opened_form.dart';
import '../../pages.dart';
import '../../widgets/loading_dialog.dart';
import '../../widgets/text_field.dart';

late String formId;
late String title;
late String descriptionEnglish;
late String descriptionHindi;

late BuildContext context;

late TextEditingController locoNameController;
late TextEditingController locoNumberController;

void initConst(
  String formID,
  String formTitle,
  String formDescriptionEnglish,
  String formDescriptionHindi,
) {
  formId = formID;
  title = formTitle;
  descriptionEnglish = formDescriptionEnglish;
  descriptionHindi = formDescriptionHindi;

  locoNameController = TextEditingController();
  locoNumberController = TextEditingController();
}

AppBar buildAppBar() {
  return AppBar(
    title: Text(
      "Create $title Form",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      textAlign: TextAlign.center,
    ),
    centerTitle: true,
  );
}

Widget buildMainBody() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 40),
      descriptionEnglish.isEmpty
          ? const SizedBox()
          : Text(
              descriptionEnglish,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
      descriptionEnglish.isEmpty
          ? const SizedBox()
          : const SizedBox(height: 20),
      descriptionHindi.isEmpty
          ? const SizedBox()
          : Text(
              descriptionHindi,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
      descriptionHindi.isEmpty ? const SizedBox() : const SizedBox(height: 20),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            MyTextField(
              controller: locoNameController,
              hintText: 'Enter Loco Name',
              isTextCentered: true,
              textCapitalization: TextCapitalization.characters,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            MyTextField(
              controller: locoNumberController,
              hintText: 'Enter Loco Number',
              isTextCentered: true,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                onTap();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  'Open Form',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

void onTap() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const LoadingDialog(
      title: "Opening Form...",
    ),
  );

  SmartShedOpenedForm? createdForm = await FormOpeningController.createForm(
    formId,
    locoNameController.text,
    locoNumberController.text,
  );

  if (!context.mounted) return;
  GoRouter.of(context).pop();

  if (createdForm != null) {
    GoRouter.of(context).go(
      "${Pages.form}/${createdForm.id}",
      extra: createdForm,
    );
  } else {
    GoRouter.of(context).go(Pages.dashboard);
  }
}

void disposeConst() {
  locoNameController.dispose();
  locoNumberController.dispose();
}
