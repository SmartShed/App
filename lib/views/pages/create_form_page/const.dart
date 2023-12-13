import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/forms/opening.dart';
import '../../../models/opened_form.dart';
import '../../pages.dart';
import '../../widgets/loading_dialog.dart';
import '../../widgets/text_field.dart';

TextEditingController locoNameController = TextEditingController();
TextEditingController locoNumberController = TextEditingController();

AppBar buildAppBar(String title, Function()? onPressed) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      textAlign: TextAlign.center,
    ),
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.add_box_outlined),
      ),
    ],
  );
}

Widget buildMainBody(
  BuildContext context,
  String formId,
  String title,
  String descriptionEnglish,
  String descriptionHindi,
) {
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
            ),
            const SizedBox(height: 20),
            MyTextField(
              controller: locoNumberController,
              hintText: 'Enter Loco Number',
              isTextCentered: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                onTap(context, formId);
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

void onTap(
  BuildContext context,
  String formId,
) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const LoadingDialog(
      title: "Opening Form...",
    ),
  );

  FormOpeningController.init();
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
