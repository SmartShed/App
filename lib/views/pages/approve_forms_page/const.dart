import 'package:flutter/material.dart';

import '../../../controllers/forms/approving.dart';
import '../../../models/opened_form.dart';
import '../../widgets/opened_form_tile.dart';

List<SmartShedOpenedForm> forms = [];
bool isFormsLoading = true;

late BuildContext context;
late void Function(void Function()) changeState;

void initConst(void Function(void Function()) setState) {
  changeState = setState;

  forms = [];
  isFormsLoading = true;

  _initForms();
}

Future<void> _initForms() async {
  changeState(() => isFormsLoading = true);
  forms = await FormApprovingController.getUnapprovedForms();
  changeState(() => isFormsLoading = false);
}

AppBar buildAppBar() {
  return AppBar(
    title: const Text(
      'APPROVE FORMS',
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
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        !isFormsLoading && forms.isEmpty
            ? 'No Forms Found'
            : 'Forms to Approve',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 20),
      isFormsLoading
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
              itemCount: forms.length,
              itemBuilder: (context, index) {
                return OpenedFormTile(
                  index: index,
                  openedForm: forms[index],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
            ),
    ],
  );
}
