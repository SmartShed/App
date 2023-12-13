import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../controllers/dashboard/for_all.dart';
import '../../../controllers/dashboard/for_me.dart';
import '../../../models/opened_form.dart';
import '../../../models/section.dart';
import '../../widgets/drawer.dart';
import 'const.dart';

class DashboardPageDesktop extends StatefulWidget {
  const DashboardPageDesktop({super.key});

  @override
  State<DashboardPageDesktop> createState() => _DashboardPageDesktopState();
}

class _DashboardPageDesktopState extends State<DashboardPageDesktop> {
  List<SmartShedSection> _sections = [];
  List<SmartShedOpenedForm> _recentlyOpenedForms = [];
  bool _isSectionLoading = true;
  bool _isRecentlyOpenedFormsLoading = true;

  @override
  void initState() {
    super.initState();

    DashboardForAllController.init();
    DashboardForMeController.init();

    _initSections();
    _initRecentlyOpenedForms();
  }

  Future<void> _initSections() async {
    _sections = await DashboardForAllController.getSections();

    setState(() {
      _isSectionLoading = false;
    });
  }

  Future<void> _initRecentlyOpenedForms() async {
    _recentlyOpenedForms =
        await DashboardForMeController.getRecentlyOpenedForms();

    setState(() {
      _isRecentlyOpenedFormsLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bg,
      appBar: buildAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await _initSections();
          await _initRecentlyOpenedForms();
        },
        child: Row(
          children: [
            const MyDrawer(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      buildSectionsList(
                        _isSectionLoading,
                        _sections,
                      ),
                      const SizedBox(height: 30),
                      buildRecentlyOpenedFormsList(
                        _isRecentlyOpenedFormsLoading,
                        _recentlyOpenedForms,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
