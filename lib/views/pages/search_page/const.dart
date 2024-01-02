import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../controllers/forms/search.dart';
import '../../../controllers/toast/toast.dart';
import '../../../models/opened_form.dart';
import '../../localization/search.dart';
import '../../localization/toast.dart';
import '../../widgets/opened_form_tile.dart';
import '../../widgets/text_field.dart';

late BuildContext context;
late void Function(void Function()) changeState;

List<SmartShedOpenedForm> searchResults = [];
bool isSearchResultsLoading = true;
bool isSearched = false;

late TextEditingController formTitleController;
late TextEditingController locoTypeController;
late TextEditingController locoNumberController;

void initConst(void Function(void Function()) setState) {
  changeState = setState;

  formTitleController = TextEditingController();
  locoTypeController = TextEditingController();
  locoNumberController = TextEditingController();

  searchResults = [];
  isSearchResultsLoading = true;
  isSearched = false;
}

void disposeConst() {
  formTitleController.dispose();
  locoTypeController.dispose();
  locoNumberController.dispose();

  searchResults = [];
  isSearchResultsLoading = true;
  isSearched = false;
}

Future<void> search() async {
  if (formTitleController.text.isEmpty &&
      locoTypeController.text.isEmpty &&
      locoNumberController.text.isEmpty) {
    ToastController.warning(
        Toast_LocaleData.enter_at_least_one_field.getString(context));
    return;
  }

  changeState(() {
    isSearchResultsLoading = true;
    isSearched = true;
  });

  searchResults = [];

  List<SmartShedOpenedForm>? results = await FormsSearchController.search(
    formTitleController.text,
    locoTypeController.text,
    locoNumberController.text,
  );

  if (results == null) {
    if (!context.mounted) return;
    ToastController.error(
        Toast_LocaleData.error_searching_forms.getString(context));
    changeState(() => isSearchResultsLoading = false);
    return;
  }

  if (results.isEmpty) {
    if (!context.mounted) return;
    ToastController.warning(Toast_LocaleData.no_form_found.getString(context));
    changeState(() => isSearchResultsLoading = false);
    return;
  }

  changeState(() {
    searchResults = results;
    isSearchResultsLoading = false;
  });
}

AppBar buildAppBar() {
  return AppBar(
    title: Text(
      Search_LocaleData.title.getString(context),
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
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: buildLocoTypeField()),
                const SizedBox(width: 1),
                Expanded(child: buildLocoNumberField()),
              ],
            ),
            buildFormTitleField(),
            const SizedBox(height: 10),
            buildSearchButton(),
          ],
        ),
      ),
      const SizedBox(height: 10),
      buildSearchResults(),
    ],
  );
}

Widget buildFormTitleField() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: MyTextField(
      controller: formTitleController,
      hintText: Search_LocaleData.form_title.getString(context),
      suffixIcon: formTitleController.text.isNotEmpty
          ? IconButton(
              onPressed: () => changeState(() => formTitleController.clear()),
              icon: const Icon(Icons.clear),
            )
          : null,
      onChanged: (_) => changeState(() {}),
    ),
  );
}

Widget buildLocoTypeField() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: MyTextField(
      controller: locoTypeController,
      hintText: Search_LocaleData.loco_type.getString(context),
      suffixIcon: locoTypeController.text.isNotEmpty
          ? IconButton(
              onPressed: () => changeState(() => locoTypeController.clear()),
              icon: const Icon(Icons.clear),
            )
          : null,
      onChanged: (_) => changeState(() {}),
    ),
  );
}

Widget buildLocoNumberField() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: MyTextField(
      controller: locoNumberController,
      hintText: Search_LocaleData.loco_number.getString(context),
      suffixIcon: locoNumberController.text.isNotEmpty
          ? IconButton(
              onPressed: () => changeState(() => locoNumberController.clear()),
              icon: const Icon(Icons.clear),
            )
          : null,
      onChanged: (_) => changeState(() {}),
    ),
  );
}

Widget buildSearchButton() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: ElevatedButton(
      onPressed: search,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.search,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              Search_LocaleData.search.getString(context),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildSearchResults() {
  if (!isSearched) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        Search_LocaleData.search_for_forms.getString(context),
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black.withOpacity(0.2),
        ),
      ),
    );
  }

  if (isSearchResultsLoading) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: CircularProgressIndicator(),
    );
  }

  if (searchResults.isEmpty) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        Search_LocaleData.no_forms_found.getString(context),
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black.withOpacity(0.2),
        ),
      ),
    );
  }

  return ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: searchResults.length,
    itemBuilder: (context, index) {
      return OpenedFormTile(
        index: index,
        openedForm: searchResults[index],
      );
    },
    separatorBuilder: (context, index) {
      return const SizedBox(height: 12);
    },
  );
}
