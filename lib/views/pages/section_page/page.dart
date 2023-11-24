// import 'package:flutter/material.dart';

// import '../../../constants/colors.dart';

// import '../../../models/section.dart';
// import '../../../models/form.dart';
// import '../../../models/opened_form.dart';

// import '../../../controllers/dashboard/for_all.dart';
// import '../../../controllers/dashboard/for_me.dart';

// import '../../widgets/drawer.dart';
// import '../../widgets/form_tile.dart';
// import '../../widgets/opened_form_tile.dart';

// class SectionPage extends StatefulWidget {
//   static const String routeName = '/section';

//   final String sectionId;
//   final String sectionName;

//   const SectionPage({
//     Key? key,
//     required this.sectionId,
//     required this.sectionName,
//   }) : super(key: key);

//   factory SectionPage.fromSection(SmartShedSection section) {
//     return SectionPage(
//       sectionId: section.id,
//       sectionName: section.name,
//     );
//   }

//   factory SectionPage.fromSectionJson(Map<String, dynamic> json) {
//     return SectionPage.fromSection(SmartShedSection.fromJson(json));
//   }

//   @override
//   State<SectionPage> createState() => _SectionPageState();
// }

// class _SectionPageState extends State<SectionPage> {
//   List<SmartShedForm> _formsForSection = [];
//   List<OpenedSmartShedForm> _recentlyOpenedForms = [];
//   List<OpenedSmartShedForm> _allOpenedForms = [];

//   bool _isFormsForSectionLoading = true;
//   bool _isRecentlyOpenedFormsLoading = true;
//   bool _isAllOpenedFormsLoading = true;

//   @override
//   void initState() {
//     super.initState();

//     DashboardForAllController.init();
//     DashboardForMeController.init();

//     _initFormsForSection();
//     _initRecentlyOpenedForms();
//     _initAllOpenedForms();
//   }

//   Future<void> _initFormsForSection() async {
//     _formsForSection =
//         await DashboardForAllController.getFormsForSection(widget.sectionId);
//     setState(() {
//       _isFormsForSectionLoading = false;
//     });
//   }

//   Future<void> _initRecentlyOpenedForms() async {
//     _recentlyOpenedForms =
//         await DashboardForMeController.getRecentlyOpenedFormsForSection(
//             widget.sectionId);
//     setState(() {
//       _isRecentlyOpenedFormsLoading = false;
//     });
//   }

//   Future<void> _initAllOpenedForms() async {
//     _allOpenedForms =
//         await DashboardForMeController.getRecentlyOpenedFormsForSection(
//             widget.sectionId);
//     setState(() {
//       _isAllOpenedFormsLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorConstants.bg,
//       appBar: AppBar(
//         title: Text(
//           widget.sectionName,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: ColorConstants.primary,
//       ),
//       drawer: const MyDrawer(),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 30,
//           ),
//           child: Column(
//             children: [
//               _buildFormsList(),
//               const SizedBox(height: 20),
//               _buildRecentlyOpenedFormsList(),
//               const SizedBox(height: 20),
//               _buildAllOpenedFormsList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFormsList() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Forms',
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 20,
//           ),
//         ),
//         const SizedBox(height: 20),
//         _isFormsForSectionLoading
//             ? ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: 6,
//                 itemBuilder: (context, index) {
//                   return const FormTileShimmer();
//                 },
//               )
//             : ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: _formsForSection.length,
//                 itemBuilder: (context, index) {
//                   return FormTile(
//                     index: index,
//                     form: _formsForSection[index],
//                   );
//                 },
//               ),
//       ],
//     );
//   }

//   Widget _buildRecentlyOpenedFormsList() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 20),
//         const Text(
//           'Recently Opened Forms',
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 20,
//           ),
//         ),
//         const SizedBox(height: 20),
//         _isRecentlyOpenedFormsLoading
//             ? ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: 6,
//                 itemBuilder: (context, index) {
//                   return const OpenedFormTileShimmer();
//                 },
//               )
//             : ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: _recentlyOpenedForms.length,
//                 itemBuilder: (context, index) {
//                   return OpenedFormTile(
//                     index: index,
//                     openedForm: _recentlyOpenedForms[index],
//                   );
//                 },
//               ),
//       ],
//     );
//   }

//   Widget _buildAllOpenedFormsList() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 20),
//         const Text(
//           'All Opened Forms',
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 20,
//           ),
//         ),
//         const SizedBox(height: 20),
//         _isAllOpenedFormsLoading
//             ? ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: 6,
//                 itemBuilder: (context, index) {
//                   return const OpenedFormTileShimmer();
//                 },
//               )
//             : ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: _allOpenedForms.length,
//                 itemBuilder: (context, index) {
//                   return OpenedFormTile(
//                     index: index,
//                     openedForm: _allOpenedForms[index],
//                   );
//                 },
//               ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';
import './mobile.dart';
import './desktop.dart';

import '../../../models/section.dart';

class SectionPage extends StatelessWidget {
  static const String routeName = '/section';

  final String sectionId;
  final String sectionName;

  const SectionPage({
    Key? key,
    required this.sectionId,
    required this.sectionName,
  }) : super(key: key);

  factory SectionPage.fromSection(SmartShedSection section) {
    return SectionPage(
      sectionId: section.id,
      sectionName: section.name,
    );
  }

  factory SectionPage.fromSectionJson(Map<String, dynamic> json) {
    return SectionPage.fromSection(SmartShedSection.fromJson(json));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: SectionPageMobile(
        sectionId: sectionId,
        sectionName: sectionName,
      ),
      desktopBody: SectionPageDesktop(
        sectionId: sectionId,
        sectionName: sectionName,
      ),
    );
  }
}
