import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages.dart';
import '../../../constants/colors.dart';
import '../../../controllers/auth/login.dart';
import '../../../controllers/toast/toast.dart';
import '../../widgets/loading_dialog.dart';
import './widgets/dialog_text_button.dart';

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
            const Text(
              "Are you sure you want to logout?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            DialogTextButton(
              text: "No",
              onPressed: () {
                // Navigator.pop(context);
                GoRouter.of(context).pop();
              },
              paddingForBox: paddingForBox * 0.75,
              textButtonPaddingForBox: textButtonPaddingForBox,
            ),
            const SizedBox(height: 10),
            DialogTextButton(
              text: "Yes",
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
      builder: (_) => const LoadingDialog(
        title: "Logging out...",
      ),
    );

    bool isLoggedOut = await LoginController.logout();

    if (!context.mounted) return;
    // Navigator.pop(context);
    GoRouter.of(context).pop();

    if (isLoggedOut) {
      ToastController.success("Logged out successfully.");
      if (!context.mounted) return;
      // Navigator.pop(context);
      GoRouter.of(context).pop();
      // Navigator.pushNamedAndRemoveUntil(
      // context, Pages.login, (Route<dynamic> route) => false);
      GoRouter.of(context).go(Pages.login);
    } else {
      ToastController.error(
        "Something went wrong. Please try again later.",
      );
      // Navigator.pop(context);
      GoRouter.of(context).pop();
    }
  }
}
