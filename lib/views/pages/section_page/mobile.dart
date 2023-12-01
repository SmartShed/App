import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../models/form.dart';
import '../../../models/opened_form.dart';
import '../../../controllers/dashboard/for_all.dart';
import '../../../controllers/dashboard/for_me.dart';
import '../../widgets/drawer.dart';
import './const.dart';

class SectionPageMobile extends StatefulWidget {
  final String title;

  const SectionPageMobile({
    Key? key,
    required this.title,
  }) : super(key: key);

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
        await DashboardForAllController.getFormsForSection(widget.title);
    setState(() {
      _isFormsForSectionLoading = false;
    });
  }

  Future<void> _initRecentlyOpenedForms() async {
    _recentlyOpenedForms =
        await DashboardForMeController.getRecentlyOpenedFormsForSection(
            widget.title);
    setState(() {
      _isRecentlyOpenedFormsLoading = false;
    });
  }

  Future<void> _initAllOpenedForms() async {
    _allOpenedForms =
        await DashboardForMeController.getRecentlyOpenedFormsForSection(
            widget.title);
    setState(() {
      _isAllOpenedFormsLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bg,
      appBar: buildAppBar(widget.title),
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
