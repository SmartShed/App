import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../constants/colors.dart';

class LoadingDialog extends StatelessWidget {
  final String title;

  const LoadingDialog({
    Key? key,
    this.title = "Loading...",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CupertinoActivityIndicator(
            radius: 15,
            color: ColorConstants.primary,
          ),
          const SizedBox(width: 20),
          Text(title),
        ],
      ),
    );
  }
}
