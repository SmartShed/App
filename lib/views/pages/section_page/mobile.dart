import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../models/section.dart';
import '../../../models/form.dart';
import '../../../models/opened_form.dart';
import '../../../controllers/dashboard/for_all.dart';
import '../../../controllers/dashboard/for_me.dart';
import '../../widgets/drawer.dart';
import './const.dart';

class SectionPageMobile extends StatefulWidget {
  final String sectionId;
  final String sectionName;

  const SectionPageMobile({
    Key? key,
    required this.sectionId,
    required this.sectionName,
  }) : super(key: key);

  factory SectionPageMobile.fromSection(SmartShedSection section) {
    return SectionPageMobile(
      sectionId: section.id,
      sectionName: section.name,
    );
  }

  factory SectionPageMobile.fromSectionJson(Map<String, dynamic> json) {
    return SectionPageMobile.fromSection(SmartShedSection.fromJson(json));
  }

  @override
  State<SectionPageMobile> createState() => _SectionPageMobileState();
}

class _SectionPageMobileState extends State<SectionPageMobile> {
  List<SmartShedForm> _formsForSection = [];
  List<OpenedSmartShedForm> _recentlyOpenedForms = [];
  List<OpenedSmartShedForm> _allOpenedForms = [];

  bool _isFormsForSectionLoading = true;
  bool _isRecentlyOpenedFormsLoading = true;
  bool _isAllOpenedFormsLoading = true;

  @override
  void initState() {
    super.initState();

    DashboardForAllController.init();
    DashboardForMeController.init();

    _initFormsForSection();
    _initRecentlyOpenedForms();
    _initAllOpenedForms();
  }

  Future<void> _initFormsForSection() async {
    _formsForSection =
        await DashboardForAllController.getFormsForSection(widget.sectionId);
    setState(() {
      _isFormsForSectionLoading = false;
    });
  }

  Future<void> _initRecentlyOpenedForms() async {
    _recentlyOpenedForms =
        await DashboardForMeController.getRecentlyOpenedFormsForSection(
            widget.sectionId);
    setState(() {
      _isRecentlyOpenedFormsLoading = false;
    });
  }

  Future<void> _initAllOpenedForms() async {
    _allOpenedForms =
        await DashboardForMeController.getRecentlyOpenedFormsForSection(
            widget.sectionId);
    setState(() {
      _isAllOpenedFormsLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bg,
      appBar: AppBar(
        title: Text(
          widget.sectionName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorConstants.primary,
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Column(
            children: [
              buildFormsList(
                _isFormsForSectionLoading,
                _formsForSection,
              ),
              const SizedBox(height: 20),
              buildRecentlyOpenedFormsList(
                _isRecentlyOpenedFormsLoading,
                _recentlyOpenedForms,
              ),
              const SizedBox(height: 20),
              buildAllOpenedFormsList(
                _isAllOpenedFormsLoading,
                _allOpenedForms,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
