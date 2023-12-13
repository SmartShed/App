import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/colors.dart';
import '../../../../controllers/toast/toast.dart';
import 'dialog_text_button.dart';

class DisableGoogleSignInDialog extends StatelessWidget {
  final void Function() onDisable;
  final double paddingForBox;

  const DisableGoogleSignInDialog({
    Key? key,
    required this.onDisable,
    required this.paddingForBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: paddingForBox / 2,
              ),
              child: const Text(
                "You are currently logged in with Google. Do you want to disable Google Sign In?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            DialogTextButton(
              text: "No, I want to keep it",
              onPressed: () {
                // Navigator.pop(context);
                GoRouter.of(context).pop();
              },
              paddingForBox: paddingForBox,
            ),
            const SizedBox(height: 10),
            DialogTextButton(
              text: "Yes, disable it",
              onPressed: () {
                // Navigator.pop(context);
                GoRouter.of(context).pop();
                ToastController.show(
                  "Google Sign In disabled successfully.",
                );
                onDisable();
              },
              paddingForBox: paddingForBox,
            ),
          ],
        ),
      ),
    );
  }
}
