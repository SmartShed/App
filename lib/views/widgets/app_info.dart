import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colors.dart';
import '../../controllers/auth/login.dart';
import '../../controllers/toast/toast.dart';
import '../localization/settings.dart';

const String appVersion = 'v1.1.6';
const String devUri = 'https://github.com/SmartShed';
const String latestAppDownload =
    'https://github.com/SmartShed/App/releases/latest/download/SmartShed_{version}.apk';

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

class AppInfo extends StatefulWidget {
  const AppInfo({super.key});

  @override
  State<AppInfo> createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  String latestVersion = '';

  @override
  void initState() {
    super.initState();
    setLatestVersion();
  }

  Future<void> setLatestVersion() async {
    final Dio dio = Dio();
    final Response response = await dio.get(
      'https://api.github.com/repos/SmartShed/App/releases/latest',
    );

    if (!mounted) return;

    setState(() {
      latestVersion = response.data['tag_name'];
    });
  }

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
                  await launchUrl(
                    Uri.parse(devUri),
                    mode: LaunchMode.externalApplication,
                    webOnlyWindowName: '_blank',
                  );
                } catch (e) {
                  if (!context.mounted) return;
                  ToastController.error(context.formatString(
                      Settings_LocaleData.could_not_launch_url
                          .getString(context),
                      [devUri]));
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
            // Only show if it's not the latest version and platform is not web
            if (!kIsWeb) ...[
              const SizedBox(height: 20),
              Text(
                Settings_LocaleData.get_latest_version.getString(context),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (latestVersion != '' && latestVersion != appVersion) ...[
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.primary.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 2,
                  ),
                  child: Text(
                    context.formatString(
                      Settings_LocaleData.new_version_available
                          .getString(context),
                      [latestVersion],
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
              if (latestVersion == appVersion) ...[
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.primary.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 2,
                  ),
                  child: Text(
                    Settings_LocaleData.you_are_on_latest_version
                        .getString(context),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 5),
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
                      Uri.parse(
                        latestAppDownload.replaceFirst(
                            '{version}', latestVersion),
                      ),
                      mode: LaunchMode.externalApplication,
                    );
                  } catch (e) {
                    if (!context.mounted) return;
                    ToastController.error(context.formatString(
                        Settings_LocaleData.could_not_launch_url
                            .getString(context),
                        [
                          latestAppDownload.replaceFirst(
                              '{version}', latestVersion)
                        ]));
                  }
                },
                child: Row(
                  children: [
                    Text(
                      context.formatString(
                        Settings_LocaleData.latest_version.getString(context),
                        [latestVersion == '' ? '' : '($latestVersion)'],
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
