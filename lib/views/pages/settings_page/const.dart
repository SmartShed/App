import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/colors.dart';
import '../../../controllers/settings/settings.dart';
import '../../../controllers/toast/toast.dart';
import '../../localization/settings.dart';
import '../../widgets/dropdown.dart';

late BuildContext context;
late void Function(void Function()) changeState;
late bool isMobile;

late TextEditingController _dateFormatController;
late TextEditingController _timeFormatController;
late TextEditingController _languageController;

late DateTime _dateTime;

const String appVersion = '1.1.0';
final Uri devUri = Uri.parse('https://github.com/SmartShed');
final Uri emailUri = Uri(scheme: 'mailto', path: 'smartshedteam@gmail.com');

void initConst(
  void Function(void Function()) setState,
  bool mobile,
) {
  changeState = setState;
  isMobile = mobile;

  _dateTime = DateTime.now();

  _dateFormatController = TextEditingController(
      text:
          "${UserSettingsController.dateFormat} (${DateFormat(UserSettingsController.dateFormat).format(_dateTime)})");

  _timeFormatController = TextEditingController(
      text:
          "${UserSettingsController.timeFormat} (${DateFormat(UserSettingsController.timeFormat).format(_dateTime)})");

  _languageController =
      TextEditingController(text: UserSettingsController.language);
}

AppBar buildAppBar() {
  return AppBar(
    title: Text(
      Settings_LocaleData.title.getString(context),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
  );
}

Widget buildBody() {
  return SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildDateFormatPicker(),
        const SizedBox(height: 20),
        buildTimeFormatPicker(),
        const SizedBox(height: 20),
        buildLanguagePicker(),
        const SizedBox(height: 20),
        buildResetButton(),
        const SizedBox(height: 20),
        buildAppInfo(),
        const SizedBox(height: 40),
      ],
    ),
  );
}

Widget buildDateFormatPicker() {
  return Container(
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
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: _responsive(
        [
          Text(
            Settings_LocaleData.choose_date_format.getString(context),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          MyDropdown(
            key: ValueKey(UserSettingsController.dateFormat),
            hintText: Settings_LocaleData.date_format.getString(context),
            controller: _dateFormatController,
            items: UserSettingsController.dateFormatList
                .map((e) => "$e (${DateFormat(e).format(_dateTime)})")
                .toList(),
            onChanged: () {
              String dateFormat =
                  _dateFormatController.text.split(' (')[0].trim();
              UserSettingsController.saveDateFormat(dateFormat);
              changeState(() {});
            },
          ),
        ],
      ),
    ),
  );
}

Widget buildTimeFormatPicker() {
  return Container(
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
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: _responsive(
        [
          Text(
            Settings_LocaleData.choose_time_format.getString(context),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          MyDropdown(
            key: ValueKey(UserSettingsController.timeFormat),
            hintText: Settings_LocaleData.time_format.getString(context),
            controller: _timeFormatController,
            items: UserSettingsController.timeFormatList
                .map((e) => "$e (${DateFormat(e).format(_dateTime)})")
                .toList(),
            onChanged: () {
              String timeFormat =
                  _timeFormatController.text.split(' (')[0].trim();
              UserSettingsController.saveTimeFormat(timeFormat);
              changeState(() {});
            },
          ),
        ],
      ),
    ),
  );
}

Widget buildLanguagePicker() {
  return Container(
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
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: _responsive(
        [
          Text(
            Settings_LocaleData.choose_language.getString(context),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          MyDropdown(
            key: ValueKey(UserSettingsController.language),
            hintText: Settings_LocaleData.language.getString(context),
            controller: _languageController,
            items: UserSettingsController.languageList,
            onChanged: () {
              String language = _languageController.text;
              UserSettingsController.saveLanguage(language);
              changeState(() {});
            },
          ),
        ],
      ),
    ),
  );
}

Widget buildResetButton() {
  return Container(
    width: double.infinity,
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
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              await UserSettingsController.reset();
              _dateFormatController.text =
                  "${UserSettingsController.dateFormat} (${DateFormat(UserSettingsController.dateFormat).format(_dateTime)})";
              _timeFormatController.text =
                  "${UserSettingsController.timeFormat} (${DateFormat(UserSettingsController.timeFormat).format(_dateTime)})";
              _languageController.text = UserSettingsController.language;

              changeState(() {});
              if (!context.mounted) return;
              ToastController.success(
                  Settings_LocaleData.all_settings_reset.getString(context));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Text(
                Settings_LocaleData.reset.getString(context),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildAppInfo() {
  return Container(
    width: double.infinity,
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
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Settings_LocaleData.app_version.getString(context),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            appVersion,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            Settings_LocaleData.developed_by.getString(context),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(0),
              ),
              visualDensity: VisualDensity.compact,
              surfaceTintColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              overlayColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            onPressed: () async {
              try {
                await launchUrl(
                  devUri,
                );
              } catch (e) {
                if (!context.mounted) return;
                ToastController.error(context.formatString(
                    Settings_LocaleData.could_not_launch_url.getString(context),
                    [devUri.toString()]));
              }
            },
            child: Row(
              children: [
                Text(
                  Settings_LocaleData.developed_by_value.getString(context),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.primary,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.open_in_new,
                  size: 16,
                  color: ColorConstants.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            Settings_LocaleData.contact_us.getString(context),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(0),
              ),
              visualDensity: VisualDensity.compact,
              surfaceTintColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              overlayColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            onPressed: () async {
              try {
                await launchUrl(
                  emailUri,
                );
              } catch (e) {
                if (!context.mounted) return;
                ToastController.error(context.formatString(
                    Settings_LocaleData.could_not_launch_url.getString(context),
                    [emailUri.toString()]));
              }
            },
            child: Row(
              children: [
                Text(
                  context.formatString(
                    Settings_LocaleData.contact_us_value.getString(context),
                    [emailUri.path],
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.primary,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.open_in_new,
                  size: 16,
                  color: ColorConstants.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            Settings_LocaleData.report_bug.getString(context),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(0),
              ),
              visualDensity: VisualDensity.compact,
              surfaceTintColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              overlayColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
            ),
            onPressed: () async {
              try {
                await launchUrl(
                  emailUri,
                );
              } catch (e) {
                if (!context.mounted) return;
                ToastController.error(context.formatString(
                    Settings_LocaleData.could_not_launch_url.getString(context),
                    [emailUri.toString()]));
              }
            },
            child: Row(
              children: [
                Text(
                  context.formatString(
                    Settings_LocaleData.report_bug_value.getString(context),
                    [emailUri.path],
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.primary,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.open_in_new,
                  size: 16,
                  color: ColorConstants.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _responsive(List<Widget> children) {
  if (isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        children[0],
        const SizedBox(height: 10),
        children[1],
      ],
    );
  } else {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: children[0]),
        const SizedBox(width: 10),
        Expanded(child: children[1]),
      ],
    );
  }
}

void disposeConst() {
  _dateFormatController.dispose();
  _timeFormatController.dispose();
  _languageController.dispose();
}
