import 'package:flutter/material.dart';

import '../../pages.dart';
import '../../../constants/colors.dart';

import '../../../models/section.dart';
import '../../../models/opened_form.dart';

import '../../../controllers/dashboard/for_all.dart';
import '../../../controllers/dashboard/for_me.dart';

import '../../widgets/drawer.dart';
import '../../widgets/section_tile.dart';
import '../../widgets/opened_form_tile.dart';

class DashboardPageDesktop extends StatefulWidget {
  const DashboardPageDesktop({super.key});

  @override
  State<DashboardPageDesktop> createState() => _DashboardPageDesktopState();
}

class _DashboardPageDesktopState extends State<DashboardPageDesktop> {
  List<SmartShedSection> _sections = [];
  List<OpenedSmartShedForm> _recentlyOpenedForms = [];
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
      appBar: AppBar(
        title: const Text(
          'DASHBOARD',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorConstants.primary,
        automaticallyImplyLeading: false,
      ),
      body: Row(
        children: [
          const MyDrawer(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  children: [
                    _buildSectionsList(),
                    const SizedBox(height: 30),
                    _buildRecentlyOpenedFormsList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sections',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20),
        _isSectionLoading
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const SectionTileShimmer();
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _sections.length,
                itemBuilder: (context, index) {
                  return SectionTile(
                    index: index,
                    section: _sections[index],
                  );
                },
              ),
      ],
    );
  }

  Widget _buildRecentlyOpenedFormsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recently Opened Forms',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20),
        _isRecentlyOpenedFormsLoading
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const OpenedFormTileShimmer();
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _recentlyOpenedForms.length,
                itemBuilder: (context, index) {
                  return OpenedFormTile(
                    index: index,
                    openedForm: _recentlyOpenedForms[index],
                  );
                },
              ),
      ],
    );
  }
}
