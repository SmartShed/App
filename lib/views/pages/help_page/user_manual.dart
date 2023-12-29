import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../constants/api.dart';
import '../../localization/settings.dart';
import '../../responsive/dimensions.dart';
import 'page.dart';

class UserManual extends StatefulWidget {
  static const String routeName = '${HelpPage.routeName}/user-manual';

  const UserManual({Key? key}) : super(key: key);

  @override
  State<UserManual> createState() => _UserManualState();
}

class _UserManualState extends State<UserManual> {
  double _horizontalPadding = 0;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    if (width < mobileWidth) {
      _horizontalPadding = 0;
    } else {
      _horizontalPadding = (width - 900) / 2;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Settings_LocaleData.user_manual_title.getString(context),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: SfPdfViewer.network(
          APIConstants.userManualUrl,
          enableDoubleTapZooming: true,
          interactionMode: PdfInteractionMode.pan,
          enableDocumentLinkAnnotation: true,
          enableTextSelection: true,
          canShowScrollStatus: true,
        ),
      ),
    );
  }
}
