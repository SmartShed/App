import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:smartshed/views/localization/approve_forms.dart';

import '../../../controllers/forms/approving.dart';
import '../../../models/opened_form.dart';
import '../../widgets/opened_form_tile.dart';

List<SmartShedOpenedForm> forms = [];
List<SmartShedOpenedForm> approvedForms = [];
bool isFormsLoading = true;
bool isApprovedFormsLoading = true;

late BuildContext context;
late void Function(void Function()) changeState;

void initConst(void Function(void Function()) setState) {
  changeState = setState;

  forms = [];
  isFormsLoading = true;

  _initForms();
  _initApprovedForms();
}

void disposeConst() {
  forms = [];
  isFormsLoading = true;
}

Future<void> _initForms() async {
  changeState(() => isFormsLoading = true);
  forms = await FormApprovingController.getUnapprovedForms();
  changeState(() => isFormsLoading = false);
}

Future<void> _initApprovedForms() async {
  changeState(() => isApprovedFormsLoading = true);
  approvedForms = await FormApprovingController.getApprovedForms();
  changeState(() => isApprovedFormsLoading = false);
}

AppBar buildAppBar() {
  return AppBar(
    title: Text(
      ApproveForms_LocaleData.title.getString(context),
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
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        !isFormsLoading && forms.isEmpty
            ? ApproveForms_LocaleData.no_form_found.getString(context)
            : ApproveForms_LocaleData.forms_to_approve.getString(context),
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
      const SizedBox(height: 20),
      Text(
        !isApprovedFormsLoading && approvedForms.isEmpty
            ? ApproveForms_LocaleData.approved_forms_empty.getString(context)
            : ApproveForms_LocaleData.approved_forms.getString(context),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 20),
      isApprovedFormsLoading
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
              itemCount: approvedForms.length,
              itemBuilder: (context, index) {
                return OpenedFormTile(
                  index: index,
                  openedForm: approvedForms[index],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
            ),
    ],
  );
}
