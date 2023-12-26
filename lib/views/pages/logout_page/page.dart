import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/colors.dart';
import '../../../controllers/auth/login.dart';
import '../../../controllers/toast/toast.dart';
import '../../localization/logout.dart';
import '../../pages.dart';
import '../../widgets/dialog_text_button.dart';
import '../../widgets/loading_dialog.dart';

class LogoutPage extends StatelessWidget {
  static const String routeName = '/logout';

  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double paddingForBox;
    double textButtonPaddingForBox;

    if (width < 600) {
      paddingForBox = 20;
      textButtonPaddingForBox = 5;
    } else {
      paddingForBox = width * 0.2;
      textButtonPaddingForBox = 10;
    }

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: paddingForBox,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.bg,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Logout_LocaleData.logout_message.getString(context),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            DialogTextButton(
              text: Logout_LocaleData.no.getString(context),
              onPressed: () {
                // Navigator.pop(context);
                GoRouter.of(context).pop();
              },
              paddingForBox: paddingForBox * 0.75,
              textButtonPaddingForBox: textButtonPaddingForBox,
            ),
            const SizedBox(height: 10),
            DialogTextButton(
              text: Logout_LocaleData.yes.getString(context),
              onPressed: () {
                _logout(context);
              },
              paddingForBox: paddingForBox * 0.75,
              textButtonPaddingForBox: textButtonPaddingForBox,
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => LoadingDialog(
        title: Logout_LocaleData.logging_out.getString(context),
      ),
    );

    await LoginController.logout();

    if (!context.mounted) return;
    GoRouter.of(context).pop();

    ToastController.success(
      Logout_LocaleData.logged_out.getString(context),
    );
    if (!context.mounted) return;
    GoRouter.of(context).pop();
    GoRouter.of(context).go(Pages.login);
  }
}
