import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../controllers/smartshed/smartshed.dart';
import '../../../../controllers/toast/toast.dart';
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
    title: const Text(
      'CREATE SECTION',
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
        'Create Section',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 20),
      Text(
        'Enter the name of the section you want to create.',
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 40),
      MyTextField(
        hintText: 'Section Name',
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
        child: const Text(
          'Create Section',
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

void createSection() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const LoadingDialog(
      title: "Creating Section...",
    ),
  );

  bool isSectionCreated =
      await SmartShedController.createSection(sectionNameController.text);

  if (!context.mounted) return;
  GoRouter.of(context).pop();

  if (isSectionCreated) {
    ToastController.success('Section created successfully');
    if (!context.mounted) return;
    GoRouter.of(context).pop();
  }
}
