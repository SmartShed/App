import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colors.dart';
import '../../controllers/auth/login.dart';
import '../../controllers/toast/toast.dart';
import '../localization/settings.dart';

const String appVersion = '1.1.3';
final Uri devUri = Uri.parse('https://github.com/SmartShed');
final Uri latestAppUri =
    Uri.parse('https://github.com/SmartShed/App/releases/latest');

final Uri contactUsEmailUri = Uri(
  scheme: 'mailto',
  path: 'smartshedteam@gmail.com',
  query: encodeQueryParameters(<String, String>{
    'subject':
        'SmartShed App - Contact Us by ${LoginController.user?.name} (${LoginController.user?.email})',
  }),
);

final Uri reportBugEmailUri = Uri(
  scheme: 'mailto',
  path: 'smartshedteam@gmail.com',
  query: encodeQueryParameters(<String, String>{
    'subject':
        'SmartShed App - Bug Report by ${LoginController.user?.name} (${LoginController.user?.email})',
  }),
);

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
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
                  await launchUrl(devUri);
                } catch (e) {
                  if (!context.mounted) return;
                  ToastController.error(context.formatString(
                      Settings_LocaleData.could_not_launch_url
                          .getString(context),
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
                  await launchUrl(contactUsEmailUri);
                } catch (e) {
                  if (!context.mounted) return;
                  ToastController.error(context.formatString(
                      Settings_LocaleData.could_not_launch_url
                          .getString(context),
                      [contactUsEmailUri.toString()]));
                }
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      context.formatString(
                        Settings_LocaleData.contact_us_value.getString(context),
                        [contactUsEmailUri.path],
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
                  await launchUrl(reportBugEmailUri);
                } catch (e) {
                  if (!context.mounted) return;
                  ToastController.error(context.formatString(
                      Settings_LocaleData.could_not_launch_url
                          .getString(context),
                      [reportBugEmailUri.toString()]));
                }
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      context.formatString(
                        Settings_LocaleData.report_bug_value.getString(context),
                        [reportBugEmailUri.path],
                      ),
                      overflow: TextOverflow.ellipsis,
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
            ),
            const SizedBox(height: 20),
            Text(
              Settings_LocaleData.get_latest_version.getString(context),
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
                  await launchUrl(latestAppUri);
                } catch (e) {
                  if (!context.mounted) return;
                  ToastController.error(context.formatString(
                      Settings_LocaleData.could_not_launch_url
                          .getString(context),
                      [latestAppUri.toString()]));
                }
              },
              child: Row(
                children: [
                  Text(
                    Settings_LocaleData.latest_version.getString(context),
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
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
