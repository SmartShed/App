import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../../models/full_form.dart';
import '../../../models/question.dart';
import '../../../models/sub_form.dart';

late Font hindiFont;
late Font hindiFontBold;
late Font englishFont;
late Font englishFontBold;
late List<Font> fallbackFonts;

Future<void> setFont() async {
  hindiFont = Font.ttf(await rootBundle.load('assets/fonts/kohinoor.ttf'));
  hindiFontBold =
      Font.ttf(await rootBundle.load('assets/fonts/kohinoor-bold.ttf'));

  englishFont = await PdfGoogleFonts.latoRegular();
  englishFontBold = await PdfGoogleFonts.latoBold();

  fallbackFonts = [
    Font.ttf(await rootBundle.load('assets/fonts/kohinoor.ttf')),
    Font.ttf(await rootBundle.load('assets/fonts/kohinoor-bold.ttf')),
    await PdfGoogleFonts.latoRegular(),
    await PdfGoogleFonts.latoBold(),
  ];
}

void printForm(SmartShedForm form) async {
  String pdfTitle = "${form.title} - ${form.locoName} ${form.locoNumber}";

  await setFont();

  final pdf = Document(
    title: pdfTitle,
    version: PdfVersion.pdf_1_5,
    author: 'SmartShed',
    keywords: 'SmartShed, PDF, Form',
    creator: 'SmartShed',
    subject: 'SmartShed Form',
    pageMode: PdfPageMode.fullscreen,
  );

  pdf.addPage(
    MultiPage(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      header: (Context context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Central Railway   मध्य रेल',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 8,
                  font: englishFont,
                  fontFallback: fallbackFonts,
                ),
              ),
              Text(
                'Diesel Loco Shed ,Pune   डीजल लोको शेड ,पुणे',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 8,
                  font: englishFont,
                  fontFallback: fallbackFonts,
                ),
              ),
            ],
          ),
        );
      },
      footer: (Context context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Loco - ${form.locoName} ${form.locoNumber}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 8,
                  font: englishFont,
                  fontFallback: fallbackFonts,
                ),
              ),
              Text(
                "Date - ${form.createdAtDateString}",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 8,
                  font: englishFont,
                  fontFallback: fallbackFonts,
                ),
              ),
            ],
          ),
        );
      },
      orientation: PageOrientation.portrait,
      pageFormat: PdfPageFormat.a4,
      build: (Context context) {
        return <Widget>[
          buildHeader(form),
          SizedBox(height: 7),
          buildQuestionEnd(color: PdfColors.grey),
          SizedBox(height: 7),
          if (form.questions.isNotEmpty) buildQuestionHeader(),
          ...form.questions.map((question) => buildQuestion(question)),
          if (form.questions.isNotEmpty) buildQuestionEnd(),
          for (var subForm in form.subForms) ...[
            SizedBox(height: 7),
            buildSubForm(subForm),
            if (subForm.questions.isNotEmpty) buildQuestionHeader(),
            ...subForm.questions.map((question) => buildQuestion(question)),
            if (subForm.questions.isNotEmpty) buildQuestionEnd(),
          ],
        ];
      },
    ),
  );

  await Printing.layoutPdf(
    name: pdfTitle,
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}

Widget buildHeader(SmartShedForm form) {
  return Column(
    children: [
      Text(
        form.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          font: englishFontBold,
          fontFallback: fallbackFonts,
        ),
      ),
      SizedBox(height: 5),
      Text(
        form.descriptionEnglish,
        textAlign: TextAlign.center,
        style: TextStyle(
          font: englishFont,
          fontFallback: fallbackFonts,
        ),
      ),
      SizedBox(height: 2),
      Text(
        form.descriptionHindi,
        textAlign: TextAlign.center,
        style: TextStyle(
          font: hindiFont,
          fontFallback: fallbackFonts,
        ),
      ),
      SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Loco - ${form.locoName} ${form.locoNumber}",
            textAlign: TextAlign.left,
            style: TextStyle(
              font: englishFont,
              fontFallback: fallbackFonts,
            ),
          ),
          Text(
            "Date - ${form.createdAtDateString}",
            textAlign: TextAlign.right,
            style: TextStyle(
              font: englishFont,
              fontFallback: fallbackFonts,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget buildSubForm(SmartShedSubForm subForm) {
  return Table(
    border: const TableBorder(
      bottom: BorderSide(width: 0.5, color: PdfColors.grey),
      left: BorderSide(width: 0.5, color: PdfColors.black),
      right: BorderSide(width: 0.5, color: PdfColors.black),
      top: BorderSide(width: 0.5, color: PdfColors.black),
      horizontalInside: BorderSide(width: 0.5, color: PdfColors.grey),
      verticalInside: BorderSide(width: 0.5, color: PdfColors.grey),
    ),
    children: [
      TableRow(
        decoration: const BoxDecoration(color: PdfColors.grey100),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  subForm.titleEnglish,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    font: englishFont,
                    fontFallback: fallbackFonts,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  subForm.titleHindi,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    font: hindiFont,
                    fontFallback: fallbackFonts,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

Widget buildQuestionHeader({bool isTop = false}) {
  return Table(
    border: TableBorder(
      bottom: const BorderSide(width: 0.5, color: PdfColors.grey),
      left: const BorderSide(width: 0.5, color: PdfColors.black),
      right: const BorderSide(width: 0.5, color: PdfColors.black),
      top: BorderSide(
          width: 0.5, color: isTop ? PdfColors.black : PdfColors.grey),
      horizontalInside: const BorderSide(width: 0.5, color: PdfColors.grey),
      verticalInside: const BorderSide(width: 0.5, color: PdfColors.grey),
    ),
    children: [
      TableRow(
        decoration: const BoxDecoration(color: PdfColors.grey100),
        children: [
          Expanded(
            flex: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Parts / Work to be done',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10,
                      font: englishFontBold,
                      fontFallback: fallbackFonts,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    'पुर्जें / कार्य किया जाए',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 9,
                      font: hindiFontBold,
                      fontFallback: fallbackFonts,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Action Taken',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10,
                      font: englishFontBold,
                      fontFallback: fallbackFonts,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    'कार्रवाई',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 9,
                      font: hindiFontBold,
                      fontFallback: fallbackFonts,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tech. Name',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10,
                      font: englishFontBold,
                      fontFallback: fallbackFonts,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    'तक. का नाम',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 9,
                      font: hindiFontBold,
                      fontFallback: fallbackFonts,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget buildQuestion(SmartShedQuestion question) {
  return Table(
    border: const TableBorder(
      bottom: BorderSide(width: 0.5, color: PdfColors.grey),
      left: BorderSide(width: 0.5, color: PdfColors.black),
      right: BorderSide(width: 0.5, color: PdfColors.black),
      top: BorderSide(width: 0.5, color: PdfColors.grey),
      horizontalInside: BorderSide(width: 0.5, color: PdfColors.grey),
      verticalInside: BorderSide(width: 0.5, color: PdfColors.grey),
    ),
    children: [
      TableRow(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.textEnglish,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10,
                      font: englishFont,
                      fontFallback: fallbackFonts,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    question.textHindi,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 9,
                      font: hindiFont,
                      fontFallback: fallbackFonts,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 2,
              ),
              child: Text(
                question.ans ?? '',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 10,
                  font: englishFont,
                  fontFallback: fallbackFonts,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 2,
              ),
              child: Text(
                question.history.isEmpty
                    ? ''
                    : question.history.first.editedBy.name,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 10,
                  font: englishFont,
                  fontFallback: fallbackFonts,
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget buildQuestionEnd({PdfColor color = PdfColors.black}) {
  return Table(
    border: TableBorder(
      bottom: BorderSide(width: 0.5, color: color),
    ),
    children: [
      TableRow(
        children: [
          Container(
            width: double.infinity,
          ),
        ],
      ),
    ],
  );
}
