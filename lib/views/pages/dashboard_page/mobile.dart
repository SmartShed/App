import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import '../../../constants/colors.dart';

class DashboardPageMobile extends StatefulWidget {
  const DashboardPageMobile({super.key});

  @override
  State<DashboardPageMobile> createState() => _DashboardPageMobileState();
}

class _DashboardPageMobileState extends State<DashboardPageMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DASHBOARD',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorConstants.primary,
      ),
      drawer: const MyDrawer(),
      body: const Center(
        child: Text('Dashboard'),
      ),
    );
  }
}
